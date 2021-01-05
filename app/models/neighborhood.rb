class Neighborhood < ActiveRecord::Base
  has_many :bathrooms
  has_many :reviews, through: :bathrooms

  def all_bathrooms
    Bathroom.all.select{|bathroom| bathroom.neighborhood == self}
  end

  def most_popular_in_neighborhood
    self.all_bathrooms.sort_by{|bathroom| bathroom.reviews.length}.last(2)
  end

  def low_security
    self.all_bathrooms.select{|level| Review.find_by(level.security_level) == "low"}
  end

  def best_flush
    self.all_bathrooms.select{|flush| flush.flush_factor == "jet engine"}
  end
  
  def short_wait
    self.all_bathrooms.select{|wait| wait.wait_time < 6}
  end

  def cleanest
    self.all_bathrooms.select{|clean| clean.cleanliness > 8}
  end

  def handicap_access
    self.all_bathrooms.select{|access| access.handicap_accessible == true}
  end

  def baby_station
    self.all_bathrooms.select{|baby| baby.baby_changing_station == true}
  end
end