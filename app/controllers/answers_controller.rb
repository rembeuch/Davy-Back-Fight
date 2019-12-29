class AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def answer_params
    params.require(:answer).permit(:text, :position, :multiplier)
  end
end
