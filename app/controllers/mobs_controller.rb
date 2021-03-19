class MobsController < ApplicationController
    layout "application", except: [:show]
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
    @place = @mob.place
    @player = current_user.player
    if @player.in_fight == false && @player.health > 0
      @player.update(mob_power: pick_mob_score)
      @player.update(mob_health: @mob.health)
      @player.update(player_power: (@player.player_power += rand(1..11)))
      @player.update(in_fight: true)
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

  def run
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(health: (@player.health - 1))
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(in_fight: false)
    redirect_to place_path(@mob.place_id)
    @disable_nav = false
  end

  def retry_player
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(mob_power: pick_mob_score)
    @player.update(health: (@player.health - 1))
    redirect_to mob_path(@mob)
  end

  def resolve
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    if @player.player_power + ( @player.level - @mob.level ) > @player.mob_power
      @player.update(mob_health: (@player.mob_health - 1))
      @player.update(player_power: 0)
      @player.update(fight: 'default')
      if @player.mob_health > 0
        @player.update(mob_power: pick_mob_score)
        redirect_to mob_path(@mob)
      else
        @player.update(in_fight: false)
        @player.update(exp: (@player.exp + @mob.exp))
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

  def reward
    @mob = Mob.find(params[:mob_id])
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

  def mob_params
    params.require(:mob).permit(:name, :image, :health, :bonus, :level, :exp)
  end
end
