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
    if @tournament.status == 'en cours'
      lap_turn
    end
  end

  def lap_turn
    if Time.now.getlocal("+00:00") > @tournament.start + 60 && @participations_validées.count > 1
      if @participations_validées.index(@current_participation) % 2 == 0 && @current_participation.answer != "En attente" && @participations_validées[(@participations_validées.index(@current_participation)) + 1].answer == "En attente"
        @current_participation.update(lap: (@current_participation.lap += 1))
        @participations_validées[(@participations_validées.index(@current_participation)) + 1].update(status: 'terminée')
      elsif @participations_validées.index(@current_participation) % 2 != 0 && @current_participation.answer != "En attente" && @participations_validées[(@participations_validées.index(@current_participation)) - 1].answer == "En attente"
        @current_participation.update(lap: (@current_participation.lap += 1))
        @participations_validées[(@participations_validées.index(@current_participation)) - 1].update(status: 'terminée')
      end
      @tournament.update(lap: (@tournament.lap += 1))
      @tournament.update(start: (@tournament.start + 60))
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :start)
  end
end
