# spec/factories/movies.rb

FactoryBot.define do
  factory :movie do
    title { "Movie Title" }
    year { "2022" }
    plot { "Movie Plot" }
    poster_url { "https://example.com/poster.jpg" }
    user # Esto establecerá la asociación con un usuario
  end
end
