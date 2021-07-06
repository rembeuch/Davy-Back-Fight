class PlacesController < ApplicationController
  before_action :check_player
  before_action :check_token

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
    @article = Article.second
    @player = current_user.player
    @place = Place.find(params[:id])
    @players = Player.where(position: @place.name).where(in_fight: false).where(health: [1..10])
  end

  def move_player
    @player = current_user.player
    if @player.in_fight == false
    @player = current_user.player
    @place = Place.find(params[:place_id])
    @player.update(position: @place.name)
    redirect_to place_path(@place)
    else
      redirect_to island_path(Place.find_by(name: @player.position).island), notice: 'vous êtes engagé dans un combat'
    end
  end

  def check_token
    @player = current_user.player
    @place = Place.find_by(name: @player.position)
    if FightToken.find_by(enemy: current_user.player) != nil && FightToken.find_by(enemy: current_user.player).created_at - Time.now <= -120
      @enemy = current_user.player
      @enemy.update(in_fight: false)
      @enemy.update(in_fight_enemy: "")
      @enemy.update(fight: "default")
    end
    if @player.quest_logs != nil
      @player.quest_logs.each do |log|
        if log.created_at + 1.days < Time.now
          log.destroy
        end
      end
    end
  end

  def place_params
    params.require(:place).permit(:name, :image, :condition)
  end
end
