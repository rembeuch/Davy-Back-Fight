class PlayersController < ApplicationController
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

  def pvp_launch
    @player = current_user.player
    @player.update(action: (@player.action - 1))
    redirect_to player_pvp_path(params[:player_id])
  end

  def pvp
    @disable_nav = true
    @enemy = Player.find(params[:player_id])
    @enemy.update(in_fight: true)
    @player = current_user.player
    if @player.in_fight == false && @player.health > 0
      @player.update(mob_power: pick_enemy_score)
      @player.update(mob_health: @enemy.health)
      @player.update(in_fight_enemy: @enemy.user.pseudo)
      @player.update(player_power: (@player.player_power += rand(1..11)))
      @player.update(in_fight: true)
    end
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
    @enemy.update(in_fight: false)
    redirect_to place_path(Place.find_by(name: @player.position))
    @disable_nav = false
  end

  def resolve
    @enemy = Player.find(params[:player_id])
    @player = current_user.player
    if @player.player_power + ( @player.level - @enemy.level ) >= @player.mob_power && current_user.berrys > @enemy.user.berrys
      @player.update(mob_health: (@player.mob_health - 1))
      @player.update(player_power: 0)
      @player.update(in_fight: false)
      @player.update(fight: 'default')
      @player.update(in_fight_enemy: "")
      @enemy.update(in_fight: false)
      if @player.mob_health > 0
        redirect_to place_path(Place.find_by(name: @player.position))
      else
        @player.update(exp: (@player.exp + (@enemy.level*100)))
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


  private

  def player_params
    params.require(:player).permit(:position)
  end
end
