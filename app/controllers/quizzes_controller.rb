class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to quiz_path
    else
      render :new
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to quiz_path, notice: 'modifié!'
    else
      render :edit
    end
  end

  def plus
    current_user.update(numero_quiz: (current_user.numero_quiz + 1))
    redirect_to quiz_path
  end

  private

  def quiz_params
    params.require(:quiz).permit(:answer, :question, :numero)
  end
end
