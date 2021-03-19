class IslandsController < ApplicationController
  before_action :check_player

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
  end

  def move_player
    @player = current_user.player
    @island = Island.find(params[:island_id])
    @player.update(position: @island.places[0].name)
    redirect_to island_path(@island)
  end

  private

  def island_params
    params.require(:island).permit(:name, :image, :category)
  end
end
