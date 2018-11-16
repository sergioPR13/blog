class ArticlesController < ApplicationController
    #GET /articles
    def index
        #Obtiene todos los registros de la base de datos (BD) Article (SELECT * FROM)
        @articles = Article.all
    end
    
    #GET /articles/:id
    def show
        #Encontrar un registro por su id
        @article = Article.find(params[:id])
        #WHERE
        #Article.where.not(" id = ? ",params[:id])
    end

    #GET /articles/new
    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end
    
    #POST /articles
    def create
        #INSERT INTO
        #@article=Article.new(title: params[:article][:title], body: params[:article][:body])
        @article=Article.new(article_params) # Ver PRIVATE
        if @article.save
            redirect_to @article
        else
            render :new
        end
    end
  
    # DELETE /articles/:id
    def destroy
        #DELETE FROM articles
        @article=Article.find(params[:id])
        @article.destroy #Destroy elimina el objeto de la BD
        redirect_to articles_path
    end
    
    # PUT /article/:id
    def update
        # UPDATE
        # @article.update_attributes({title: 'Nuevo título'})
    end

    private
    def article_params
        params.require(:article).permit(:title,:body)
    end

end