class MovieDetailsController < ApplicationController
  def show
    movie_id = params[:id] 
    @movie = fetch_movie_details(movie_id)
    
    if @movie
      render 'show'
    else
      flash[:error] = "La película no se encontró."
      redirect_to movies_path
    end
  end
  def fetch_movie_details(movie_id)
    api_key = '4cdb0dbd3ea893e166f8a05fbade0aa4'
    url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}&language=es-ES"
    
    response = RestClient.get(url)
    data = JSON.parse(response.body)
    
    data
  end
  
end
