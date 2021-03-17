class MobsController < ApplicationController
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
    @mob = Mob.find(params[:id])
    @place = @mob.place
    @player = current_user.player
    if @player.in_fight == false
      @player.update(mob_power: pick_mob_score)
    end
    @player.update(in_fight: true)

  end

  def pick_mob_score
  rand(10..21)
  end

  def pick_player_power
  rand(1..11)
  end

  private

  def mob_params
    params.require(:mob).permit(:name, :image, :health, :bonus, :level, :exp)
  end
end
