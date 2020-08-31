class ParticipationsController < ApplicationController
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @user = current_user
    @participation = Participation.new
    @participation.tournament = @tournament
    @participation.user = @user
    if @participation.save
      redirect_to tournament_path(@tournament)
    else
      render :new
    end
  end

  def fdd_answer
    @tournament = Tournament.find(params[:tournament_id])
    @current_participation = current_user.participations.where(tournament: @tournament).first
    @current_participation.update(answer: "Fruit du Démon")
    redirect_to tournament_path(@tournament)
  end

  def granit_answer
    @tournament = Tournament.find(params[:tournament_id])
    @current_participation = current_user.participations.where(tournament: @tournament).first
    @current_participation.update(answer: "Granit marin")
    redirect_to tournament_path(@tournament)
  end

  def katana_answer
    @tournament = Tournament.find(params[:tournament_id])
    @current_participation = current_user.participations.where(tournament: @tournament).first
    @current_participation.update(answer: "Katana")
    redirect_to tournament_path(@tournament)
  end
end
