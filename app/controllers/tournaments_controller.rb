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
    @participations_validées = Participation.all.where(tournament: @tournament, status: "Validée").sort_by(&:id)
    if @tournament.status == 'en cours'
      lap_turn
    end
    @gains = (@tournament.participations.count * 10_000)
  end

  def lap_turn
    if Time.now.getlocal("+00:00") > @tournament.start + 300 && @participations_validées.count > 1
      @participations_validées.each do |participation|
        if participation.answer == 'En attente' || participation.engage == true
          participation.update(status: "terminée")
        end
      end
      @participations_validées.each do |participation|
        participation.update(answer: "En attente")
      end
      @tournament.update(lap: (@tournament.lap += 1))
      @tournament.update(start: (@tournament.start + 300))
      redirect_to tournament_path(@tournament)
    end
  end

  def win
    @tournament = Tournament.find(params[:tournament_id])
    @current_participation = current_user.participations.where(tournament: @tournament).first
    current_user.update(berrys: (current_user.berrys + (@tournament.participations.count * 10_000)))
    @current_participation.update(engage: true)
    redirect_to tournament_path(@tournament)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :start)
  end
end
