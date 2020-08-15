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
    @current_participation = current_user.participations.where(tournament: @tournament).first
    @participations_validées = Participation.all.where(tournament: @tournament, status: "Validée")
    @participations_éliminées = Participation.all.where(tournament: @tournament, status: "éliminée")
    odd_elements(@participations_validées)
  end

  def odd_elements(array)
    @participations_odd = []
    @participations_even = []
    array.each do |participation|
      if participation.id.odd?
        @participations_odd.push(participation)
      else
        @participations_even.push(participation)
      end
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :start)
  end
end
