class Neighborhood < ActiveRecord::Base
  has_many :bathrooms
  has_many :reviews, through: :bathrooms

  def all_bathrooms
    Bathroom.all.select{|bathroom| bathroom.neighborhood == self}
  end

end