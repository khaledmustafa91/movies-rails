class Review < ApplicationRecord
  belongs_to :movie
  validate_presence_of :user, :stars, :body
end
