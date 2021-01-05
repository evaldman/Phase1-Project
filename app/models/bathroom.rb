class Bathroom < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :neighborhood

  def all_reviews
    Review.all.select{|review| review.bathroom == self}
  end

  def self.low_security
    Review.all.select{|level| level.security_level == "low"}
  end

  def self.best_flush
    Review.all.select{|flush| flush.flush_factor == "jet engine"}
  end
  
  def self.short_wait
    Review.all.select{|wait| wait.wait_time < 6}
  end

  def self.cleanest
    Review.all.select{|clean| clean.cleanliness > 8}
  end

  def self.handicap_access
    Review.all.select{|access| access.handicap_accessible == true}
  end

  def self.baby_station
    Review.all.select{|baby| baby.baby_changing_station == true}
  end

  def self.most_reviews
    Bathroom.all.sort_by{|bathroom| bathroom.reviews.length}.last(2)
  end 

    # create new review, which creates new bathroom as well

end
