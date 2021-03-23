class IslandsController < ApplicationController
  before_action :check_player
  before_action :check_token

  def check_player
    if current_user.player == nil
      redirect_to new_player_path
    end
  end

  def new
    @island = Island.new
  end

  def create
    @island = Island.new(island_params)

    if @island.save
      redirect_to islands_path
    else
      render :new
    end
  end

  def index
    @player = current_user.player
    @article = Article.second
    @islands = Island.all
  end

  def show
    @player = current_user.player
    @island = Island.find(params[:id])
    @article = Article.second
  end

  def move_player
    @player = current_user.player
    if @player.in_fight == false
    @island = Island.find(params[:island_id])
    @player.update(position: @island.places[0].name)
    redirect_to island_path(@island)
    else
      redirect_to islands_path, notice: 'vous êtes engagé dans un combat'
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
  end

  private

  def island_params
    params.require(:island).permit(:name, :image, :category)
  end
end
