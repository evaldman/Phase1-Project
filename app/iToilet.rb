class IToilet
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  attr_accessor :user, :neighborhood

  def run
    interface = Interface.new
    interface.welcome
   
   
  end

  private


  
end
