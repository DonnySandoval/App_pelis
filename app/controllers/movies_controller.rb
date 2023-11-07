class MoviesController < ApplicationController
  require 'rest-client'
  require 'json'

  before_action :authenticate_user!

  def index
    
    @favorite_movies = current_user.movies
    @movies = popular_movies
    
  end
  

  def create
    movie_params = {
      title: params[:movie][:title],
      year: params[:movie][:year],
      plot: params[:movie][:plot],
      poster_url: params[:movie][:poster_url],  
      user_id: current_user.id
    }

    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:success] = "Película guardada en tu lista de favoritos."
    else
      flash[:error] = "No se pudo guardar la película en tu lista de favoritos."
    end
    redirect_to movies_path
  end  

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      flash[:success] = "Película eliminada de tus favoritos."
    else
      flash[:error] = "No se pudo eliminar la película de tus favoritos."
    end
    redirect_to movies_path
    
  end

  def search
    @favorite_movies = current_user.movies
    @search_term = params[:search_term]
    @movies = popular_movies(@search_term)
    render 'search'
  end
  

  private

  def popular_movies(search_term = nil)
    api_key = '4cdb0dbd3ea893e166f8a05fbade0aa4'
    url = if search_term.present?
            "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{search_term}&language=es-ES"
          else
            "https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=es-ES"
          end

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    if data['results']
      data['results']
    else
      []
    end
  end
end
