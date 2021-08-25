class MobsController < ApplicationController
    layout "application", except: [:show]
    before_action :mob_token
  def new
    @place = Place.find(params[:place_id])
    @mob = Mob.new
  end

  def create
     @place = Place.find(params[:place_id])
    @mob = Mob.new(mob_params)
    @mob.place = @place
    if @mob.save
      redirect_to island_place_path(@place.island, @place)
    else
      render :new
    end
  end

  def show
    @disable_nav = true
    @mob = Mob.find(params[:id])
    @sum = compare
    @place = @mob.place
    @player = current_user.player
    if @player.in_fight == false && @player.health > 0
      @player.update(mob_power: pick_mob_score)
      @player.update(mob_health: @mob.health)
      @player.update(in_fight_mob: @mob.name)
      @player.update(player_power: (@player.player_power += rand(1..11)))
      @player.update(in_fight: true)
      @fight_token = FightToken.new
      @fight_token.player = @player
      @fight_token.enemy = @player
      @fight_token.save
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
        FightToken.find_by(player: token.player).destroy
        if current_user.player.health <= 0
          current_user.player.update(wanted: 0)
          @reward = current_user.player.rewards.where(category: ["FDD", "FDD LOGIA"], statut: "équipé")
          @reward.update(mob_id: Mob.all.sample.id, player_id: Player.all.select{ |player| player.user.admin == true}.first.id)
          current_user.player.rewards.delete(@reward)
          if token.player.defeated_mob.include?('random')
            token.player.update(defeated_mob: token.player.defeated_mob - ["random"])
          elsif token.player.defeated_mob.include?('Marine')
            token.player.update(defeated_mob: token.player.defeated_mob - ["Marine"])
          end
        end
      end
    end
  end

  def pick_mob_score
  rand(10..21)
  end

  def power
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(player_power: (@player.player_power += rand(1..11)))
    check_score
    redirect_to mob_path(@mob)
  end

  def death
    if @player.health <= 0
      @player.update(wanted: 0)
      @reward = @player.rewards.where(category: ["FDD", "FDD LOGIA"], statut: "équipé")
      @reward.update(mob_id: Mob.all.sample.id, player_id: Player.all.select{ |player| player.user.admin == true}.first.id)
      @player.rewards.delete(@reward)
    end
  end

  def run
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(health: (@player.health - 1))
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(in_fight_mob: "")
    @player.update(in_fight: false)
    if @player.defeated_mob.include?("random")
      @player.update(defeated_mob: @player.defeated_mob - ["random"])
    elsif @mob.condition == 'Marine'
          @player.update(defeated_mob: @player.defeated_mob - ["Marine"])
    end
    death
    if FightToken.find_by(player: current_user.player) != nil
      FightToken.find_by(player: current_user.player).destroy
    end
    redirect_to place_path(Place.find_by(name: @player.position))
    @disable_nav = false
  end

  def retry_player
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(mob_power: pick_mob_score)
    @player.update(health: (@player.health - 1))
    if @player.health <= 0
      if @player.defeated_mob.include?("random")
        @player.update(defeated_mob: @player.defeated_mob - ["random"])
      elsif @mob.condition == 'Marine'
          @player.update(defeated_mob: @player.defeated_mob - ["Marine"])
      end
      @reward = @player.rewards.where(category: ["FDD", "FDD LOGIA"], statut: "équipé")
      @reward.update(mob_id: Mob.all.sample.id, player_id: Player.all.select{ |player| player.user.admin == true}.first.id)
      @player.update(in_fight: false, wanted: 0)
      @player.rewards.delete(@reward)
      if FightToken.find_by(player: current_user.player) != nil
        FightToken.find_by(player: current_user.player).destroy
      end
    end
    redirect_to mob_path(@mob)
  end

  def resolve
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    if @player.player_power + ( @player.level - @mob.level ) + compare > @player.mob_power
      @player.update(mob_health: (@player.mob_health - 1))
      @player.update(player_power: 0)
      @player.update(fight: 'default')
      if @player.mob_health > 0
        @player.update(mob_power: pick_mob_score)
        redirect_to mob_path(@mob)
      else
        @player.update(in_fight: false)
        @player.update(in_fight_mob: "")
        @player.update(money: @player.money + @mob.exp)
        if @player.ship_options.include?("Plongeur")
          @player.update(money: @player.money + (99*@mob.exp))
        elsif @player.ship_options.include?("Scaphandrier")
          @player.update(money: @player.money + (9*@mob.exp))
        end
        @player.update(exp: (@player.exp + @mob.exp))
        if @player.defeated_mob.include?("random")
          @player.update(defeated_mob: @player.defeated_mob - ["random"])
        elsif @mob.condition == 'Marine'
          @player.update(defeated_mob: @player.defeated_mob - ["Marine"])
        end
        if ['civil','marine','tenryubito','gouvernement'].include?(@mob.category) && @player.wanted < 100
          if @mob.condition == 'tenryubito'
            @player.update(wanted: 100)
          else
            @player.update(wanted: (@player.wanted += 1))
          end
        end
        @random_reward = rand(1..100)
        if @player.abilities.include?('Pickpocket05')
          @random_reward = (@random_reward + @player.abilities.select{|ability| ability.include?('Pickpocket')}.last[-2..-1].to_i)
        end
        if @mob.rewards != [] && @random_reward >= 90
          @reward = @mob.rewards.sample
          if @reward.player.user.admin == true
            @reward.update(player_id: @player.id, statut: 'Non équipé')
            @log = QuestLog.new
            @log.player = @player
            @log.content = "Félicitations! Vous venez d'obtenir #{@reward.name}"
            @log.image = @reward.image
            @log.save
          end
        end
        if @player.defeated_mob.exclude?(@mob.name)
          @player.defeated_mob.push(@mob.name)
          @player.save
        end
        if FightToken.find_by(player: current_user.player) != nil
          FightToken.find_by(player: current_user.player).destroy
        end
        level_up
        redirect_to mob_reward_path(@mob)
      end
    else
      retry_player
    end
  end

  def check_score
    if @player.player_power > 21
      @player.update(fight: 'lose')
    end
  end

  def compare
    @sum = 0
    @rewards = current_user.player.rewards.where(statut: "équipé")
    @sum += @rewards.count
    if ["FDD"] - @rewards.map { |reward| reward.category }.join(" ").split == [] && @mob.bonus.split(" ").include?("EAU") || @mob.bonus.split(" ").include?("GRANIT")
      @sum -= 1
    end
    if ["LOGIA"] - @rewards.map { |reward| reward.category }.join(" ").split == []
      @sum += 1
    end
    if @mob.bonus != "0"
      @sum -= @mob.bonus.split(" ").count
      if @mob.bonus.include?("FDD") && ["EAU"] - @rewards.map { |reward| reward.category }.join(" ").split == [] || ["GRANIT"] - @rewards.map { |reward| reward.category }.join(" ").split == []
        @sum += 1
      end
    end
    return @sum
  end

  def reward
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @log = @player.quest_logs.last
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


  private

  def mob_params
    params.require(:mob).permit(:name, :image, :health, :bonus, :level, :exp, :condition, :category)
  end
end
