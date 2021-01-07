class User < ActiveRecord::Base
  has_many :reviews
  has_many :bathrooms, through: :reviews

  # def self.first_login(name)
  #   User.create(name: name)
  # end

  def user_reviews
    Review.all.select {|bath| bath.user == self}
  end

  def current_chosen_bathrooms
    chosen_arr = self.user_reviews.map {|review| [review.bathroom.name, review.bathroom.address, review.cleanliness, review.flush_factor, review.security_level, review.wait_time, review.handicap_accessible, review.baby_changing_station]}
  end
  
end
