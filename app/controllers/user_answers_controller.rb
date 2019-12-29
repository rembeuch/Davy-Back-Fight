class UserAnswersController < ApplicationController
  def index
    @user_answers = current_user.user_answers
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @user_answer = UserAnswer.new(user_answer_params)
    @user_answer.answer = @answer
    @user_answer.user = current_user
    if @user_answer.save
      current_user.update(berrys: (current_user.berrys - @user_answer.amount))
      redirect_to user_answers_path
      flash[:notice] = "Pari enregistré!"
    else
      flash[:notice] = "problème!"
    end
  end

  def user_answer_params
    params.require(:user_answer).permit(:amount)
  end
end
