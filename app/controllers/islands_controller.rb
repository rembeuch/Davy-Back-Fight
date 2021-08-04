class IslandsController < ApplicationController
  before_action :check_player
  before_action :check_token
  before_action :mob_token

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
    @island = Place.find_by(name: @player.position).island
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
    @captain = Player.where(crew: @player.crew, captain: true).first
    if @player.crew != "" && @captain.in_fight == true
      redirect_to island_path(Place.find_by(name: @player.position).island), notice: 'votre capitaine combat ici, vous ne pouvez pas l\'abandonner'
    elsif @player.in_fight == false
    @island = Island.find(params[:island_id])
    @player.update(position: @island.places[0].name)
    @player.update(action: (@player.action - @island.difficulty))
    if @player.visited_island.exclude?(@island.name)
      @player.update(visited_island: @player.visited_island.push(@island.name))
      @player.update(visited_place: @player.visited_place.push(@island.places.first.name))
    end
    redirect_to islands_path
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

  def mob_token
    FightToken.all.each do |token|
      if token.player == token.enemy && token.created_at - Time.now <= -600
        token.player.update(health: (token.player.health - 1))
        token.player.update(player_power: 0)
        token.player.update(fight: 'default')
        token.player.update(in_fight_enemy: "")
        token.player.update(in_fight: false)
        FightToken.find_by(player: token.player).destroy
      end
    end
  end

  private

  def island_params
    params.require(:island).permit(:name, :image, :category, :difficulty, :condition, :position)
  end
end
