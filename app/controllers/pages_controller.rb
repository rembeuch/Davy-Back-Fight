class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]

  def home
    @articles = Article.all
  end

  def index
  end

  def quiz
    @quizs = Quiz.all
    @current_quiz = Quiz.find_by(numero: current_user.numero_quiz)
  end
end
