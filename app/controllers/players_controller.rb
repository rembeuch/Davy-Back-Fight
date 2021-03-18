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
      @player.update(level: 10)
      @player.update(max_health: 5)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[8]
      @player.update(level: 9)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[7]
      @player.update(level: 8)
      @player.update(health: player.max_health)
      elsif @player.exp > Player::LEVELS[6]
      @player.update(level: 7)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[5]
      @player.update(level: 6)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[4]
      @player.update(level: 5)
      @player.update(max_health: 4)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[3]
      @player.update(level: 4)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[2]
      @player.update(level: 3)
      @player.update(health: player.max_health)
    elsif @player.exp > Player::LEVELS[1]
      @player.update(level: 2)
      @player.update(health: player.max_health)
    end
  end

  private

  def player_params
    params.require(:player).permit(:position)
  end
end
