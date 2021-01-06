class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bathroom
  belongs_to :neighborhood

  
end
