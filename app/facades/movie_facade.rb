class MovieFacade

  def self.top_movies
    MovieService.popular_movies.map { |info| Movie.new(info) }
  end

  def self.movie_search(search)
    MovieService.find_movies(search).map { |info| Movie.new(info) }
  end

  def self.search_by_id(movie_id)
    movie = MovieService.find_movie_by_id(movie_id)
    Movie.new(movie)
  end

  def self.movie_cast(movie_id)
    movie = MovieService.cast_for_movie(movie_id)
  end

  def self.movie_reviews(movie_id)
    movie = MovieService.reviews_for_movie(movie_id)
  end 
end

