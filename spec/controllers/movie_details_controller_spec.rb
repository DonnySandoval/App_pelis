# spec/controllers/movie_details_controller_spec.rb

require 'rails_helper'

RSpec.describe MovieDetailsController, type: :controller do
  describe 'GET #show' do
    it 'renders the show template when movie is found' do
      # Stub the fetch_movie_details method to return sample movie data
      allow(controller).to receive(:fetch_movie_details).and_return(sample_movie_data)

      get :show, params: { id: '12345' } # Replace '12345' with a valid movie ID

      expect(response).to render_template(:show)
      expect(assigns(:movie)).to eq(sample_movie_data)
    end

    it 'redirects to movies_path when movie is not found' do
      # Stub the fetch_movie_details method to return nil
      allow(controller).to receive(:fetch_movie_details).and_return(nil)

      get :show, params: { id: 'invalid_movie_id' } # Provide an invalid movie ID

      expect(flash[:error]).to be_present
      expect(response).to redirect_to(movies_path)
    end

 

    it 'assigns the correct movie data to @movie' do
      # Stub the fetch_movie_details method to return movie data
      movie_data = { 'title' => 'Test Movie' }
      allow(controller).to receive(:fetch_movie_details).and_return(movie_data)

      get :show, params: { id: '12345' } # Replace '12345' with a valid movie ID

      expect(assigns(:movie)).to eq(movie_data)
    end

    it 'renders the show template with valid movie data' do
      # Stub the fetch_movie_details method to return movie data
      movie_data = { 'title' => 'Test Movie' }
      allow(controller).to receive(:fetch_movie_details).and_return(movie_data)

      get :show, params: { id: '12345' } # Replace '12345' with a valid movie ID

      expect(response).to render_template(:show)
    end
  end

  def sample_movie_data
    # Replace this with sample movie data that matches the expected format
    {
      'title' => 'Sample Movie',
      'overview' => 'This is a sample movie',
      'release_date' => '2023-01-01',
      'poster_path' => '/sample_poster.jpg'
    }
  end
end
