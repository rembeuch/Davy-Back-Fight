class PlayersController < ApplicationController
  def new
    @player = Player.new
    @player.user = current_user
  end

  def create
    @player = Player.new(player_params)
    @player.user = current_user
    if @player.save
      redirect_to islands_path
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  private

   def player_params
    params.require(:player).permit(:position)
  end
end
