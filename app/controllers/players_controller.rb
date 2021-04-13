class PlayersController < ApplicationController
  before_action :check_token, except: [:new]

  def new
    @player = Player.new
    @player.user = current_user
  end

  def create
    if current_user.player != nil
      redirect_to islands_path
    else
      @player = Player.new(player_params)
      @player.user = current_user
      if @player.save
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
      FightToken.find_by(player: current_user.player).destroy
      redirect_to place_path(@place)
    end
    if FightToken.find_by(enemy: current_user.player) != nil && FightToken.find_by(enemy: current_user.player).created_at - Time.now <= -120
      @enemy = current_user.player
      @enemy.update(in_fight: false)
      @enemy.update(in_fight_enemy: "")
      @enemy.update(fight: "default")
    end
  end

  def pvp_launch
    @player = current_user.player
    @enemy = Player.find(params[:player_id])
    if @enemy.in_fight == false && @enemy.health > 0 && @player.action > 0 && @player.position == @enemy.position && @player.in_fight == false
    @player.update(action: (@player.action - 1))
    @fight_token = FightToken.new
    @fight_token.player = @player
    @fight_token.enemy = @enemy
    @fight_token.save
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
    if @player.in_fight == false && @player.health > 0
      @player.update(mob_power: pick_enemy_score)
      @player.update(mob_health: @enemy.health)
      @player.update(in_fight_enemy: @enemy.user.pseudo)
      @player.update(player_power: (@player.player_power += rand(1..11)))
      @player.update(in_fight: true)
      @enemy = Player.find(params[:player_id])
      @enemy.update(in_fight: true)
      @enemy.update(in_fight_enemy: @player.user.pseudo)
      @enemy.update(fight: "attacked")
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

  def run
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    @player.update(health: (@player.health - 1))
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(in_fight_enemy: "")
    @player.update(in_fight: false)
    enemy_setup
    if FightToken.find_by(player: current_user.player) != nil
      FightToken.find_by(player: current_user.player).destroy
    end
    redirect_to place_path(Place.find_by(name: @player.position))
    @disable_nav = false
  end

  def resolve
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    if @player.player_power + ( @player.level - @enemy.level ) > @player.mob_power
      @player.update(mob_health: (@player.mob_health - 1))
      @player.update(player_power: 0)
      @player.update(in_fight: false)
      @player.update(fight: 'default')
      @player.update(in_fight_enemy: "")
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
        redirect_to place_path(Place.find_by(name: @player.position)), notice: 'Victoire! mais votre adversaire à encore de la santé'
      else
        @player.update(exp: (@player.exp + (@enemy.level*100)))
        @log = QuestLog.new
        @log.player = @enemy
        @log.content = "vous avez été tué par #{@player.user.pseudo}"
        @log.save
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

  def reward
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
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

  def player_params
    params.require(:player).permit(:position)
  end
end
