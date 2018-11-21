class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:show,:index]
    before_action :set_article, except: [:index,:new,:create]
    
    #GET /articles
    def index
        #Obtiene todos los registros de la base de datos (BD) Article (SELECT * FROM)
        @articles = Article.all
    end
    
    #GET /articles/:id
    def show
        @article.update_visit_count
        @comment = Comment.new
    end

    #GET /articles/new
    def new
        @article = Article.new
    end

    def edit
        
    end
    
    #POST /articles
    def create
        #INSERT INTO
        @article=current_user.articles.new(article_params)
        if @article.save
            redirect_to @article
        else
            render :new
        end
    end
  
    # DELETE /articles/:id
    def destroy
        #DELETE FROM articles
        @article.destroy #Destroy elimina el objeto de la BD
        redirect_to articles_path
    end
    
    # PUT /article/:id
    def update
        if @article.update(article_params)
            redirect_to @article
        else 
            render :edit
        end
    end

    private
    def set_article
        @article=Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:body)
    end

end