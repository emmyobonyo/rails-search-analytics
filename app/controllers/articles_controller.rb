class ArticlesController < ApplicationController
    before_action :set_article, only: %i[ show edit update destroy ]
  
    def index
      # @articles = Article.all
      if params[:query].present?
        # debugger
        @articles = Article.where("title LIKE ?", "%#{params[:query]}%")
        current_user.most_searched_themes.push(params[:query])
        current_user.save
      else
        @articles = Article.all
      end
      
      if turbo_frame_request?
        render 'index', locals: { articles: @articles }
      else
        render :index
      end
    end
  
    def show
    end
  
    def new
      @article = Article.new
    end
  
    def edit
    end
  
    def create
      @article = Article.new(article_params)
      @article.user = current_user
      if @article.save
        flash[:notice] = "Article was created successfully."
        redirect_to @article
      else
        render 'new', status: :unprocessable_entity
      end
    end
  
    def update
      if @article.update(article_params)
        flash[:notice] = 'Article was updated successfully.'
        redirect_to @article
      else
        render 'edit', status: :unprocessable_entity
      end
    end
  
    def destroy
      @article.destroy
      redirect_to articles_path
    end
  
    private
      def set_article
        @article = Article.find(params[:id])
      end
  
      def article_params
        params.require(:article).permit(:title, :body)
      end
  end