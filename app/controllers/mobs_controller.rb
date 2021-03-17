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

  def mob_params
    params.require(:mob).permit(:name, :image, :health, :bonus, :level, :exp)
  end
end
