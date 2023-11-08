# spec/controllers/movies_controller_spec.rb

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }


  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'Representa la plantilla de índice' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        movie: {
          title: "Titulo",
          year: "2022",
          plot: "Argumento de la película",
          poster_url: "https://example.com/poster.jpg",
          user_id: user.id 
        }
      }
    end

    it "Crea una nueva película" do
      expect {
        post :create, params: valid_params
      }.to change(Movie, :count).by(1)
    end

    it "redirige a movies_path después de crear una película" do
      post :create, params: valid_params
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'GET #search' do
    it 'Representa la plantilla de búsqueda' do
      get :search
      expect(response).to render_template(:search)
    end

   

    it 'Asigna películas populares a @movies' do
      get :search
      expect(assigns(:movies)).not_to be_empty
    end
  end

  describe "DELETE #destroy" do
    let(:movie) { create(:movie, user: user) }
    it "Redirige a movies_path película" do
      delete :destroy, params: { id: movie.id }
      expect(response).to redirect_to(movies_path)
    end
  end
end
