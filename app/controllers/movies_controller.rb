class MoviesController < ApplicationController

  def index
   @user = User.find(current_user.id)

    if params[:keyword].present?
     @movies = MovieFacade.movie_search(params[:keyword])
    else
      @movies = MovieFacade.top_movies
    end
  end

  def show
    # @user = User.find(current_user.id)
    @movie = MovieFacade.search_by_id(params[:movie_id])
    @cast = MovieFacade.movie_cast(params[:movie_id])
    @review = MovieFacade.movie_reviews(params[:movie_id])
  end
end

