class User < ActiveRecord::Base
  has_many :reviews
  has_many :bathrooms, through: :reviews
end
