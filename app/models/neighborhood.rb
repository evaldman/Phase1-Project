class Neighborhood < ActiveRecord::Base
  has_many :bathrooms
  has_many :reviews, through: :bathrooms
end