class Movie < ApplicationRecord
  has_many :reviews

  scope :order_by_reviews_average, -> { 
    left_outer_joins(:reviews).select('AVG(reviews.stars) as star_avg, movie_id as id').group(:movie_id).order('star_avg')
  }
  scope :search, -> (query) { where("actor ILIKE :query", query: query)}

  validate_presence_of :name, :description, :year, :actor, :director, :filming_location, :country
end
