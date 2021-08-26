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

  def options_push
    @player = current_user.player
    @player.update(ship_options: (@player.ship_options.push(params[:option])), abilities_points: (@player.abilities_points -= params[:cost].to_i))
    redirect_to ship_path
  end

  def marine_toggle
    @player = current_user.player
    if @player.ship_options.include?('Marin_on') == false && @player.ship_options.include?('Provocation_on') == true
      @player.update(ship_options: (@player.ship_options.push('Marin_on')))
      @player.update(ship_options: (@player.ship_options - ['Provocation_on']))
    elsif @player.ship_options.include?('Marin_on') == false && @player.ship_options.include?('Provocation_on') == false
      @player.update(ship_options: (@player.ship_options.push('Marin_on')))
    elsif @player.ship_options.include?('Provocation_on') == false && @player.ship_options.include?('Marin_on') == true
      @player.update(ship_options: (@player.ship_options.push('Provocation_on')))
      @player.update(ship_options: (@player.ship_options - ['Marin_on']))
    elsif @player.ship_options.include?('Provocation_on') == false && @player.ship_options.include?('Provocation_on') == false
      @player.update(ship_options: (@player.ship_options.push('Provocation_on')))
    end
    redirect_to ship_path
  end

  def monsters_toggle
    @player = current_user.player
    if @player.ship_options.include?('Granit_on') == false && @player.ship_options.include?('Appat_on') == true
      @player.update(ship_options: (@player.ship_options.push('Granit_on')))
      @player.update(ship_options: (@player.ship_options - ['Appat_on']))
    elsif @player.ship_options.include?('Granit_on') == false && @player.ship_options.include?('Appat_on') == false
      @player.update(ship_options: (@player.ship_options.push('Granit_on')))
    elsif @player.ship_options.include?('Appat_on') == false && @player.ship_options.include?('Granit_on') == true
      @player.update(ship_options: (@player.ship_options.push('Appat_on')))
      @player.update(ship_options: (@player.ship_options - ['Granit_on']))
    elsif @player.ship_options.include?('Appat_on') == false && @player.ship_options.include?('Appat_on') == false
      @player.update(ship_options: (@player.ship_options.push('Appat_on')))
    end
    redirect_to ship_path
  end

end
