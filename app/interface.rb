class Interface

    attr_reader :prompt
    attr_accessor :user, :bathroom, :neighborhood

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        prompt.select("🚽 Welcome to iToilet 🚽") do |menu|
            menu.choice "Login", -> { login }
            menu.choice "Sign Up", -> { sign_up }
            menu.choice "Delete Account", -> { delete_account }
        end

    end

    def login
        name = prompt.ask("Enter Name")
        password = prompt.mask("Enter Password")
        @user = User.find_by(name: name, password: password)
        puts "Welcome #{@user.name}, please select your neighborhood"
        sleep(2)
        hoods = Neighborhood.all
        @chosen_hood_id = prompt.select("Which neighborhood are you in?", hoods)
        # puts "Welcome to #{@chosen_hood_id}"
        what_to_do_menu
    end
    def what_to_do_menu
        system 'clear'
        @user.reload
        sleep(1)
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Find a bathroom", -> { bathroom_helper}
            menu.choice "Leave a review", -> { review_helper }
        end
            
    end

    def bathroom_helper
        system 'clear'  
        n_bathroom = @chosen_hood_id.all_bathrooms
        selected_bathroom = prompt.select("Please select a bathroom", n_bathroom)
        # binding.pry
        choices = {YES: 1, NO: 2}
        review_q = prompt.select("Choose your destiny?") do |menu|
            menu.choice "yes", 1
            menu.choice "no", 2
        end
        br_review = Review.all.select{|review| review.bathroom == selected_bathroom}
       
        if review_q == 1
            print br_review
        else review_q == 2
          
             puts "Enjoy your personal time"
        
        end
       
        puts "Please come back and leave a review"
        sleep(1)
        #exit
    end

    def review_helper
        system 'clear'
        @user.reload
        hood_bathroom = @chosen_hood_id.all_bathrooms
        chosen_bathroom = prompt.select("Please select a bathroom", hood_bathroom)

        cleanliness = prompt.ask("How clean was this bathroom?").to_i
        flush_factor = prompt.ask("Flush type? jet engine, mild current, lazy river")
        security_level = prompt.ask("is there security? low, medium, high")
        wait_time = prompt.ask("How many minutes did you wait?").to_i
        handicap_accessible = prompt.yes?("Was there handicap access?")
        baby_changing_station = prompt.yes?("Was there a baby changing station?")
        # binding.pry
        Review.create(cleanliness: cleanliness, flush_factor: flush_factor, security_level: security_level, handicap_accessible: handicap_accessible, baby_changing_station: baby_changing_station, user_id: @user.id, bathroom_id: chosen_bathroom.id)
        puts "Thanks for your review #{@user.name}, please come back soon!"
    end

end
