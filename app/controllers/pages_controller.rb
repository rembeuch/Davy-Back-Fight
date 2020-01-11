class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]

  def home
    @articles = Article.all
  end

  def index
  end
end

