class ArticlesController < ApplicationController
  def index
    @articles = Articles.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def article_params
    params.require(:article).permit(:title, :image, :text, :link)
  end
end
