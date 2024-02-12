class MoviesController < ApplicationController
  def index
    movies = Movie.all
    movies = movies.search(params[:query]) if params[:query].present?

    render json: movies
  end
end