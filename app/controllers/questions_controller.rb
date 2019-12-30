class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def close
    @question = Question.find(params[:question_id])
    @question.update(closed: true)
    redirect_to question_path(@question)
  end

  def destroy
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :photo, :tag)
  end
end
