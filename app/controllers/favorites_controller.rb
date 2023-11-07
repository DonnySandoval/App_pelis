class FavoritesController < ApplicationController
  def index
    @favorite_movies = current_user.movies
  end
end
