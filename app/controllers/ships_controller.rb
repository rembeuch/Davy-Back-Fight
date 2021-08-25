class ShipsController < ApplicationController
  def ship
    @player = current_user.player
  end

  def upgrade_ship
    @player = current_user.player
    if @player.money >= params[:cost].to_i
      @player.update(ship_level: (@player.ship_level += 1), money: (@player.money -= params[:cost].to_i))
    else
      flash[:alert] = "Berrys insuffisants"
    end
  redirect_to ship_path
  end
end
