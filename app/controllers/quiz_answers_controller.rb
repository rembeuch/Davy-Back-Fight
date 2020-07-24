class QuizAnswersController < ApplicationController
  def new
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_answer = QuizAnswer.new
  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_answer = QuizAnswer.new(quiz_answer_params)
    @quiz_answer.quiz = @quiz
    if @quiz_answer.save
      redirect_to quiz_path
    else
      render :new
    end
  end

  def validation
    @quiz_answer = QuizAnswer.find(params[:quiz_answer_id])
    if @quiz_answer.status == true
      current_user.update(berrys: (current_user.berrys + 20_000))
      current_user.update(numero_quiz: (current_user.numero_quiz + 1))
    else
      current_user.update(numero_quiz: (current_user.numero_quiz + 1))
    end
  end

  def quiz_answer_params
    params.require(:quiz_answer).permit(:description, :status)
  end
end
