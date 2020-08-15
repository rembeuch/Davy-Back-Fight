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
end
