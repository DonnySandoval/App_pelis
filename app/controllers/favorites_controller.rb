class FavoritesController < ApplicationController
  def index
    
    @favorite_movies = Movie.paginate(page: params[:page], per_page: 4) # Muestra 10 películas por página
  end
  
end
