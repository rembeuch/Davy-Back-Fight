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
    if @player.in_fight == false
      @player.update(mob_power: pick_mob_score)
      @player.update(player_power: (@player.player_power += rand(1..11)))
    end
    @player.update(in_fight: true)

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
  end

  def retry_player
    @mob = Mob.find(params[:mob_id])
    @player = current_user.player
    @player.update(health: (@player.health - 1))
    @player.update(player_power: 0)
    @player.update(fight: 'default')
    @player.update(in_fight: false)
    redirect_to mob_path(@mob)
  end

  def check_score
    if @player.player_power > 21
      @player.update(fight: 'lose')
    end
  end

  private

  def mob_params
    params.require(:mob).permit(:name, :image, :health, :bonus, :level, :exp)
  end
end
