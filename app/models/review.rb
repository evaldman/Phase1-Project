class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bathroom
  belongs_to :neighborhood

  def to_s
    self.cleanliness
  end
end
