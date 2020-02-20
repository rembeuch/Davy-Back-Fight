class UserAnswersController < ApplicationController
  def index
    @user_answers = current_user.user_answers
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(params[:question_id])
    @user_answer = UserAnswer.new(user_answer_params)
    @user_answer.answer = @answer
    @user_answer.user = current_user

    if @user_answer.amount.nil?
      redirect_to question_answer_path(@question, @answer)
      flash[:notice] = "problème!"
    elsif current_user.berrys >= @user_answer.amount && @user_answer.amount.positive? && @user_answer.amount != nil
      @user_answer.save
      current_user.update(berrys: (current_user.berrys - @user_answer.amount))
      redirect_to user_answers_path
      flash[:notice] = "Pari enregistré!"
    else
      redirect_to question_answer_path(@question, @answer)
      flash[:notice] = "problème!"
    end
  end

  def win
    @user_answer = UserAnswer.find(params[:user_answer_id])
    @user_answer.user = current_user
    current_user.update(berrys: (current_user.berrys + (@user_answer.amount * @user_answer.answer.multiplier)))
    @user_answer.closed = true
    @user_answer.save
    redirect_to user_answers_path
  end

  def user_answer_params
    params.require(:user_answer).permit(:amount)
  end

  def update
    @user = current_user
    @user.update_attribute(:avatar, params[:user][:avatar])
    redirect_to user_answers_path
  end
end
