class PlayersController < ApplicationController
  before_action :check_token, except: [:new, :create]
  before_action :mob_token

  def new
    @player = Player.new
    @player.user = current_user
    @positions = []
    Place.select{|place| place.island.category == 'East Blue' && place.condition == ""}.each do |place|
      @positions.push(place.name).uniq
    end
  end

  def create
    if current_user.player != nil
      redirect_to islands_path
    else
      @player = Player.new(player_params)
      if @player.position == "" || @player.position == nil
        @player.update(position: Place.first.name)
      end
      @player.user = current_user
      @player.money = 2000000
      if @player.save
        @player.update(visited_place: @player.visited_place.push(@player.position))
        @player.update(visited_island: @player.visited_island.push(Place.find_by(name: @player.position).island.name))
        redirect_to islands_path
      else
        render :new
      end
    end
  end

  def index
  end

  def show
  end

  def check_token
    @player = current_user.player
    @place = Place.find_by(name: @player.position)
    @deads = Player.where(health: 0)
    if FightToken.find_by(player: current_user.player) != nil && current_user.player.fight_token.created_at - Time.now <= -120
      @enemy = FightToken.find_by(player: current_user.player).enemy
      @player.update(health: (@player.health - 1))
      @player.update(player_power: 0)
      @player.update(fight: 'default')
      @player.update(in_fight_enemy: "")
      @player.update(in_fight: false)
      @enemy.update(in_fight: false)
      @enemy.update(in_fight_enemy: "")
      @enemy.update(fight: "default")
      death
      FightToken.find_by(player: current_user.player).destroy
      redirect_to place_path(@place)
    end
    if FightToken.find_by(enemy: current_user.player) != nil && FightToken.find_by(enemy: current_user.player).created_at - Time.now <= -120
      @enemy = current_user.player
      @enemy.update(in_fight: false)
      @enemy.update(in_fight_enemy: "")
      @enemy.update(fight: "default")
    end
    if @deads.count > 0
      @deads.each do |dead|
        if Time.now.to_date - dead.user.last_sign_in_at.to_date >= 2 && dead.rewards.count > 0
          dead.update(health: 3, action: 3)
          dead.user.update(last_sign_in_at: Time.now)
        end
      end
    end
  end

  def pvp_launch
    @player = current_user.player
    @enemy = Player.find(params[:player_id])
    if @enemy.in_fight == false && @enemy.health > 0 && @player.action > 0 && @player.position == @enemy.position && @player.in_fight == false
    @fight_token = FightToken.new
    @fight_token.player = @player
    @fight_token.enemy = @enemy
    @fight_token.save
    @enemy.update(in_fight: true)
    @enemy.update(in_fight_enemy: @player.user.pseudo)
    @enemy.update(fight: "attacked")
    redirect_to player_pvp_path(params[:player_id])
    else
      redirect_to place_path(Place.find_by(name: @player.position)), notice: 'déja en combat'
    end
  end

  def pvp
    @disable_nav = true
    @player = current_user.player
    @enemy = Player.find(params[:player_id])
    @place = Place.find_by(name: @player.position)
    @total = compare
    if @player.in_fight == false && @player.health > 0
      @player.update(in_fight: true)
      @player.update(mob_power: pick_enemy_score)
      @player.update(mob_health: @enemy.health)
      @player.update(in_fight_enemy: @enemy.user.pseudo)
      @player.update(player_power: (@player.player_power += rand(1..11)))
      @enemy = Player.find(params[:player_id])
      compare
      end
  end

  def mob_token
    FightToken.all.each do |token|
      if token.player == token.enemy && token.created_at - Time.now <= -600
        token.player.update(health: (token.player.health - 1))
        token.player.update(player_power: 0)
        token.player.update(fight: 'default')
        token.player.update(in_fight_enemy: "")
        token.player.update(in_fight: false)
        raise
        death
        FightToken.find_by(player: token.player).destroy
      end
    end
  end

  def enemy_setup
    @enemy.update(in_fight: false)
    @enemy.update(in_fight_enemy: "")
    @enemy.update(fight: "default")
  end

  def pick_enemy_score
  rand(15..21)
  end

  def power
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    @player.update(player_power: (@player.player_power += rand(1..11)))
    check_score
    redirect_to player_pvp_path(@enemy)
  end

  def death
    @player = current_user.player
    @place = Place.find_by(name: @player.position)
    if @player.health <= 0
      @reward = @player.rewards.where(category: ["FDD", "FDD LOGIA"], statut: "équipé")
      @reward.update(mob_id: Mob.all.sample.id, player_id: Player.all.select{ |player| player.user.admin == true}.first.id)
      @player.rewards.delete(@reward)
      if @place.island.difficulty > 1
        @player.update(position: (Island.where.not(category: "Grand Line").sample.places.where(condition: "").sample.name))
      end
    end
  end

  def run
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    @player.update(action: (@player.action - 1))
    @player.update(health: (@player.health - 1))
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(in_fight_enemy: "")
    @player.update(in_fight: false)
    enemy_setup
    if @player.health <= 0
      @log = QuestLog.new
        @log.player = @player
        @log.content = "vous avez été tué par #{@enemy.user.pseudo}"
        @log.save
        death
    end
    if FightToken.find_by(player: current_user.player) != nil
      FightToken.find_by(player: current_user.player).destroy
    end
    redirect_to place_path(Place.find_by(name: @player.position))
    @disable_nav = false
  end

  def resolve
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    if @player.player_power + ( @player.level - @enemy.level ) + compare > @player.mob_power || (@player.player_power + ( @player.level - @enemy.level ) + compare == @player.mob_power && @player.user.berrys > @enemy.user.berrys)
      @player.update(mob_health: (@player.mob_health - 1))
      @player.update(action: (@player.action - 1))
      @player.update(player_power: 0)
      @player.update(in_fight: false)
      @player.update(fight: 'default')
      @player.update(in_fight_enemy: "")
      if @player.level <= @enemy.level
        @player.update(abilities_points: (@player.abilities_points += 1))
      end
      @enemy.update(health: (@enemy.health - 1))
      if FightToken.find_by(player: current_user.player) != nil
        FightToken.find_by(player: current_user.player).destroy
      end
      enemy_setup
      if @player.mob_health > 0
        @player.update(exp: (@player.exp + (@enemy.level*100)))
        @log = QuestLog.new
        @log.player = @enemy
        @log.content = "vous avez été blessé par #{@player.user.pseudo}"
        @log.save
        level_up
        redirect_to place_path(Place.find_by(name: @player.position)), notice: 'Victoire! Mais votre adversaire a encore de la santé'
      else
        @player.update(money: (@player.money + (@enemy.user.berrys/2)))
        if @player.abilities.include?('Chasseur10')
          @player.update(money: (@player.money + @enemy.user.berrys))
        elsif @player.abilities.include?('Chasseur1')
          @player.update(money: (@player.money + (@enemy.user.berrys*(@player.abilities.select{|ability| ability.include?('Chasseur')}.last[-1].to_i*0.1))))
        end
        @random_ship = rand(1..100)
        if @player.abilities.include?('MrBushido4') && @enemy.ship_level > 0 && @enemy.ship_level <= 3 && @random_ship >= 75
          @enemy.update(ship_level: 0)
          @log = QuestLog.new
          @log.player = @enemy
          @log.content = "Votre Navire à été détruit"
          @log.save
          @log = QuestLog.new
          @log.player = @player
          @log.content = "Vous avez détruit le Navire de #{@enemy.user.pseudo}"
          @log.save
        end
        @player.update(exp: (@player.exp + (@enemy.level*100)))
        @log = QuestLog.new
        @log.player = @enemy
        @log.content = "vous avez été tué par #{@player.user.pseudo}"
        @log.save
        @reward = @enemy.rewards.where(category: ["FDD", "FDD LOGIA"], statut: "équipé")
        @reward.update(mob_id: Mob.all.sample.id, player_id: Player.all.select{ |player| player.user.admin == true}.first.id)
        @enemy.rewards.delete(@reward)
        if @enemy.rewards != []
          @reward = @enemy.rewards.sample
          @reward.update(player_id: @player.id, statut: 'Non équipé')
            @log = QuestLog.new
            @log.player = @player
            @log.content = "Félicitations! Vous venez d'obtenir #{@reward.name} (Pensez à l'équipé dans votre inventaire)"
            @log.save
        end
        if Place.find_by(name: @enemy.position).island.difficulty > 1
          @enemy.update(position: (Island.where.not(category: "Grand Line").sample.places.where(condition: "").sample.name))
        end
        level_up
        redirect_to player_reward_path(@enemy)
      end
    else
      run
    end
  end

  def check_score
    if @player.player_power > 21
      @player.update(fight: 'lose')
    end
  end

  def compare
    @sum = 0
    @ship_points = 0
    @crew_points = 0
    @rewards = current_user.player.rewards.where(statut: "équipé")
    @enemy_rewards = @enemy.rewards.where(statut: "équipé")
    @sum += @rewards.count
    if ["LOGIA"] - @rewards.map { |reward| reward.category }.join(" ").split == []
      @sum += 1
    end
    if @enemy.rewards != []
      if ["FDD"] - @rewards.map { |reward| reward.category }.join(" ").split == [] && ["EAU"] - @enemy.rewards.map { |reward| reward.category }.join(" ").split == [] ||["GRANIT"] - @enemy.rewards.map { |reward| reward.category }.join(" ").split == []
        @sum -= 1
      end
      @sum -= @enemy.rewards.where(statut: "équipé").count
      if ["LOGIA"] - @enemy.rewards.map { |reward| reward.category }.join(" ").split == []
        @sum -= 1
      end
      if ["FDD"] - @enemy.rewards.map { |reward| reward.category }.join(" ").split == []  && ["EAU"] - @rewards.map { |reward| reward.category }.join(" ").split == [] || ["GRANIT"] - @rewards.map { |reward| reward.category }.join(" ").split == []
        @sum += 1
      end
    end
    if @player.crew == ''

    elsif @player.captain == true && Player.where(crew: @player.crew, position: @player.position).count > 1 || @player.ship_level >= 3 && Player.where(crew: @player.crew, position: @player.position).count > 1
      @crew_points += (Player.where(crew: @player.crew, position: @player.position).count - 1)
    end
    if @enemy.crew == ''

    elsif @enemy.captain == true && Player.where(crew: @enemy.crew, position: @enemy.position).count > 1 || @enemy.ship_level >= 3 && Player.where(crew: @enemy.crew, position: @enemy.position).count > 1
      @crew_points -= (Player.where(crew: @enemy.crew, position: @enemy.position).count - 1)
    end
    if @player.ship_level >= 10
      @ship_points += 2
    elsif @player.ship_level >= 7
      @ship_points += 1
    end
    if @enemy.ship_level >= 10
      @ship_points -= 2
    elsif @enemy.ship_level >= 7
      @ship_points -= 1
    end
    @total = (@sum + @ship_points + @crew_points)
    return @total
  end

  def reward
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    @logs = @player.quest_logs.select{ |log| log.content.include?("Félicitations")}
  end

  def level_up
    if @player.exp > Player::LEVELS[9]
      @player.update(level: 10)
      @player.update(max_health: 5)
    elsif @player.exp > Player::LEVELS[8]
      @player.update(level: 9)
    elsif @player.exp > Player::LEVELS[7]
      @player.update(level: 8)
      elsif @player.exp > Player::LEVELS[6]
      @player.update(level: 7)
    elsif @player.exp > Player::LEVELS[5]
      @player.update(level: 6)
    elsif @player.exp > Player::LEVELS[4]
      @player.update(level: 5)
      @player.update(max_health: 4)
    elsif @player.exp > Player::LEVELS[3]
      @player.update(level: 4)
    elsif @player.exp > Player::LEVELS[2]
      @player.update(level: 3)
    elsif @player.exp > Player::LEVELS[1]
      @player.update(level: 2)
    end
  end

  def crew
    @player = current_user.player
  end

  def create_crew
    @player = current_user.player
    if @player.crew == "" && Player.all.map{|player| player.crew}.exclude?(player_params[:crew])
      @player.update(crew: player_params[:crew], captain: true)
      redirect_to player_crew_path(@player)
    else
      redirect_to player_crew_path(@player), notice: 'nom déja pris'
    end
  end

  def destroy_crew
    @player = current_user.player
    Player.where(crew: @player.crew).each do |player|
      player.update(crew: "", open_crew: false, captain: false)
       @log = QuestLog.new
            @log.player = player
            @log.content = "dissolution de votre équipage"
            @log.save
    end
  redirect_to player_crew_path(@player)
  end

  def open_crew
    @player = current_user.player
    if @player.open_crew == false && @player.captain == true && @player.in_fight == false
      @player.update(open_crew: true)
    else
      @player.update(open_crew: false)
    end
      redirect_to player_crew_path(@player)
  end

  def join_crew
    @player = current_user.player
    @captain = Player.find(params[:player_id])
    if @player.captain == false && @player.crew == "" && @captain.open_crew == true
      @player.update(crew: @captain.crew)
      redirect_to player_crew_path(@player)
    else
      redirect_to player_crew_path(@player), notice: 'Cet équipage ne recrute pas pour le moment'
    end
  end

  def leave_crew
    @player = current_user.player
    @captain = Player.where(crew: @player.crew, captain: true).first
    if @captain.in_fight == false
      @player.update(crew: "")
    redirect_to player_crew_path(@player)
    else
      redirect_to player_crew_path(@player), notice: 'Vous ne pouvez pas abandonner votre capitaine lorsqu\'il combat'
    end
  end

  def kick_crew
    @player = current_user.player
    @member = Player.find(params[:player_id])
    if @player.captain == true && @player.in_fight == false && @member.in_fight == false
      @member.update(crew: "")
      @log = QuestLog.new
            @log.player = @member
            @log.content = "Vous avez été retiré de votre équipage"
            @log.save
      redirect_to player_crew_path(@player)
    else
      redirect_to player_crew_path(@player), notice: 'Vous ou le membre de votre équipage êtes en combat'
    end
  end

  private

  def player_params
    params.require(:player).permit(:position, :crew)
  end
end
