class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      redirect_to tournaments_path
    else
      render :new
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @participation = Participation.new
    @current_participation = current_user.participations.where(tournament: @tournament)
  end

  def tournament_params
    params.require(:tournament).permit(:title, :start)
  end
end


