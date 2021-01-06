class User < ActiveRecord::Base
  has_many :reviews
  has_many :bathrooms, through: :reviews

  def self.first_login(name)
    User.create(name: name)
  end
  
  end
end
