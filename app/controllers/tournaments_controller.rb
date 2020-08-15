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
    array.each_with_index do |item,index|
      if index % 2 == 0
        @participations_odd.push(item)
      else
        @participations_even.push(item)
      end
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :start)
  end
end
