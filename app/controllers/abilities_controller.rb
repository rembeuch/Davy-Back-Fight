class AbilitiesController < ApplicationController
  def index
    @player = current_user.player
  end

  def ability_push
    @player = current_user.player
    @player.update(abilities: (@player.abilities.push(params[:ability])), abilities_points: (@player.abilities_points -= params[:cost].to_i))
    redirect_to abilities_index_path
  end

  def carnassier
    @player = current_user.player
    if @player.abilities.include?("Carnassier3") && @player.action > 0
      @player.update(health: (@player.health += 1), action: (@player.action -= 1))
    elsif @player.abilities.include?("Carnassier2") && @player.action >= 2
      @player.update(health: (@player.health += 1), action: (@player.action -= 2))
    elsif @player.abilities.include?("Carnassier") && @player.action >= 3
      @player.update(health: (@player.health += 1), action: (@player.action -= 3))
    else
      flash[:alert] = "Pas assez de points d'action"
    end
    redirect_to rewards_path
  end
end
