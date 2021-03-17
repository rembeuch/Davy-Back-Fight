class PlacesController < ApplicationController
  before_action :check_player

  def check_player
    if current_user.player == nil
      redirect_to new_player_path
    end
  end

  def new
    @island = Island.find(params[:island_id])
    @place = Place.new
  end

  def create
    @island = Island.find(params[:island_id])
    @place = Place.new(place_params)
    @place.island = @island
    if @place.save
      redirect_to island_path(@island)
    else
      render :new
    end
  end

  def show
    @player = current_user.player
    @place = Place.find(params[:id])
    @island = Island.find(params[:island_id])
    @players = Player.where(position: @place.name)
  end

  def place_params
    params.require(:place).permit(:name, :image)
  end
end
