class IToilet
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  attr_accessor :user, :neighborhood

  def run
    greet
    #login_or_signup
    puts "select a neighbborhood to get started"
    #Neighborhood.find_by(name: name)
    #binding.pry
   
   
  end

  private

  def greet
    puts "Welcome to iToilet, is it number 1 or number 2?"
  end

  # def login_or_signup
  #   username = ("enter your name to log in/sign up:")
  #   @user = User.find_or_create_by(name: username)
  # end
  
end
