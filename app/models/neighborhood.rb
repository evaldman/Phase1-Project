class Neighborhood < ActiveRecord::Base
  has_many :bathrooms
  has_many :reviews, through: :bathrooms

  def to_s
    self.name
  end

  # def self.all_names
  #   self.all.map{|hood| {hood.name => hood.id}}
  # end
  
  def all_bathrooms
    Bathroom.all.select{|bathroom| bathroom.neighborhood == self}
  end

  def most_popular_in_neighborhood
    self.reviews.sort_by{|review| review.bathroom_id}
  end

  def low_security
    self.reviews.select{|level| level.security_level == "low"}
    
  end

  def best_flush
    self.reviews.select{|flush| flush.flush_factor == "jet engine"}
  end
  
  def short_wait
    self.reviews.sort_by{|wait| wait.wait_time}.first
  end

  def cleanest
    self.reviews.sort_by{|clean| clean.cleanliness}.last
  end

  def handicap_access
    self.reviews.select{|access| access.handicap_accessible == true}
  end

  def baby_station
    self.reviews.select{|baby| baby.baby_changing_station == true}
  end
end