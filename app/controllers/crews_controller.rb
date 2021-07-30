class CrewsController < ApplicationController
  def new
    @player = current_user.player
    @crew = Crew.new
  end

  def create
    @crew = Crew.new(crew_params)
    @player = current_user.player
    if @crew.save
      @crew.update(players: (@crew.players.push(@player)))
      @player.update(crew: @crew, captain: true)
      redirect_to crew_path(@crew)
    else
      render :new
    end
  end

  def show
    @player = current_user.player
    @crew = @player.crew
  end

  def crew_params
    params.require(:crew).permit(:name)
  end
end
