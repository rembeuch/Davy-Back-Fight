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

  def level_up
    if @player.exp > Player::LEVELS[9]
      @player.level = 10
    elsif @player.exp > Player::LEVELS[8]
      @player.level = 9
    elsif @player.exp > Player::LEVELS[7]
      @player.level = 8
      elsif @player.exp > Player::LEVELS[6]
      @player.level = 7
    elsif @player.exp > Player::LEVELS[5]
      @player.level = 6
    elsif @player.exp > Player::LEVELS[4]
      @player.level = 5
    elsif @player.exp > Player::LEVELS[3]
      @player.level = 4
    elsif @player.exp > Player::LEVELS[2]
      @player.level = 3
    elsif @player.exp > Player::LEVELS[1]
      @player.level = 2
    end
  end

  private

  def player_params
    params.require(:player).permit(:position)
  end
end
