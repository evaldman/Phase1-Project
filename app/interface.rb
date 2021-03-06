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
        end
    end

    def login
        name = prompt.ask("Enter Name")
            unless User.find_by(name: name)
               puts "Sorry name does not exist".colorize(:red)
               name = prompt.ask("Enter Name")
                
            end
        
        password = prompt.mask("Enter Password")
            unless User.find_by(password: password)
               puts "Sorry password does not match".colorize(:red)
               password = prompt.mask("Enter Password")
               
        end
        
        @user = User.find_by(name: name, password: password)
        puts "Welcome back #{@user.name}, please select your neighborhood".colorize(:yellow)
        sleep(2)
        # hoods = Neighborhood.all
        # @chosen_hood_id = prompt.select("Which neighborhood are you in?", hoods)
        # puts "Welcome to #{@chosen_hood_id}"
        # what_to_do_menu
        neighborhood_helper
    end

    def sign_up
        name = prompt.ask("Please select a user name")
        while User.find_by(name: name)
            puts "Sorry, this name is already taken".colorize(:red)
            puts "Please try again".colorize(:blue)
            name = prompt.ask("Please select a user name")
        end
        password = prompt.mask("Please select a password")
        @user = User.create(name: name, password: password)
        puts "Welcome #{@user.name}, you won't be disappointed!"
        sleep(2)
        
        neighborhood_helper
    end

    def neighborhood_helper
        hoods = Neighborhood.all
        @chosen_hood_id = prompt.select("Which neighborhood are you in?", hoods)
        what_to_do_menu
    end

    def what_to_do_menu
        system 'clear'
        @user.reload
        sleep(1)
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Find a Bathroom", -> { bathroom_helper}
            menu.choice "Filter Bathroom Options", -> {filter_helper} 
            menu.choice "Leave a Review", -> { review_helper }
            menu.choice "Delete a Review", -> { delete_review_helper }
            menu.choice "Update Review", -> { update_review_helper }
            menu.choice "Select a Different Neighborhood", -> { neighborhood_helper }
            menu.choice "Exit", -> { exit_helper }
        end
    end

    def bathroom_helper
        system 'clear'  
        n_bathroom = @chosen_hood_id.all_bathrooms
        selected_bathroom = prompt.select("Please select a bathroom", n_bathroom)
        review_q = prompt.select("Would you like to see a review?") do |menu|
            menu.choice "yes", 1
            menu.choice "no", 2
        end
        
        if review_q == 1
        
           c_review = selected_bathroom.chosen_bathroom.each do |array|
                puts "_______________________________"
                puts "Bathroom: #{array[0]}"
                puts "Address: #{array[1]}"
                puts "Cleanliness: #{array[2]}"
                puts "Flush Factor: #{array[3]}"
                puts "Security Level: #{array[4]}"
                puts "Wait Time: #{array[5]}"
                puts "Handicap Accessible: #{array[6]}"
                puts "Baby Changing Station: #{array[7]}"
                puts "______________________________"
            end
        else review_q == 2
            puts "Enjoy your personal time"
        end
        sleep(2)
        puts "Please come back and leave a review"
        sleep(1)
        what_to_do_menu
    end

    def filter_helper
        prompt.select("Which bathroom would you like to see?") do |menu|
            menu.choice "The cleanest", -> {cleanest_helper}
            menu.choice "Short wait time", -> {wait_helper}
            menu.choice "Handicap access", -> {h_helper}
            menu.choice "baby changing station", -> {b_helper}
        end
    end

    def review_helper
        system 'clear'
        #@user.reload
        hood_bathroom = @chosen_hood_id.all_bathrooms
        selected_bathroom = prompt.select("Please select a bathroom", hood_bathroom)
        # prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
        cleanliness = prompt.select("How clean was this bathroom?",%w(1 2 3 4 5 6 7 8 9 10)).to_i
        flush_factor = prompt.select("How nice was the flush?") do |menu|
            menu.choice "jet engine"
            menu.choice "mild current"
            menu.choice "lazy river"
        end
        security_level = prompt.select("What is the security level?", %w(High Medium Low))
        wait_time = prompt.select("How many minutes did you wait?", %w(1 2 3 4 5 6 7 8 9 10 11 12)).to_i
        handicap_accessible = prompt.yes?("Is it handicap accessible?")
        baby_changing_station = prompt.yes?("Is there a baby changing station?")
        # binding.pry
        Review.create(cleanliness: cleanliness, flush_factor: flush_factor, security_level: security_level, handicap_accessible: handicap_accessible, baby_changing_station: baby_changing_station, user_id: @user.id, bathroom_id: selected_bathroom.id)
        puts "Thanks for your review #{@user.name}!".colorize(:blue)

        sleep (4)
        what_to_do_menu
    end

    def delete_review_helper
        user_review = @user.user_reviews
        selected_review = prompt.select("Select a review to", user_review.map{|review| review.bathroom.address})
        @user.delete_a_review(selected_review)
        
    
        
        puts "Your review has been removed"
        sleep (3)
        what_to_do_menu
    end

    def update_review_helper
        user_review = @user.user_reviews
        # binding.pry
        #display all user bathrooms#user_review_name = user_review.map{}  ---> user_review[0].bathroom.name
        #user selects the review#user_bathroom_name from tty::prompt
        #update only the selected review#

        selected_review = prompt.select("Select a review", user_review.map{|review| review.bathroom.address})
        choices = {cleanliness: 1, flush_Factor: 2, security_level: 3, wait_Time: 4, handicap_accessible: 5, baby_changing_station: 6}

        usr_sel_rev =  user_review.find{|review| review.bathroom.address == selected_review}
        val = prompt.select("which feature would you like to edit?", choices)
        if val == 1
            # binding.pry
            
            up_cleanliness = prompt.select("How clean was this bathroom?",%w(1 2 3 4 5 6 7 8 9 10)).to_i
            # @selected_review.cleanliness = up_cleanliness
            usr_sel_rev.update(cleanliness: up_cleanliness)
            # binding.pry
            system('clear')
            what_to_do_menu
        elsif val == 2
            up_flush_factor = prompt.select("How nice was the flush?") do |menu|
                menu.choice "jet engine"
                menu.choice "mild current"
                menu.choice "lazy river"
            end
            usr_sel_rev.update(flush_factor: up_flush_factor)
            system('clear')
            what_to_do_menu
        elsif val == 3
            up_security_level = prompt.select("What is the security level?", %w(High Medium Low))
            usr_sel_rev.update(security_level: up_security_level)
            system('clear')
            what_to_do_menu
        elsif val == 4
            up_wait_time = prompt.select("How many minutes did you wait?", %w(1 2 3 4 5 6 7 8 9 10 11 12)).to_i
            usr_sel_rev.update(wait_time: up_wait_time)
            system('clear')
            what_to_do_menu
        elsif val == 5
            up_handicap_accessible =  prompt.yes?("Is it handicap accessible?")
            usr_sel_rev.update(handicap_accessible: up_handicap_accessible)
            system('clear')
            what_to_do_menu
        elsif val == 6
            up_baby_changing_station =  prompt.yes?("Is there a baby changing station?")
            usr_sel_rev.update(baby_changing_station: up_baby_changing_station)
            system('clear')
            what_to_do_menu
        else 
            what_to_do_menu
        end
        
    end

    def cleanest_helper
        if clean = @chosen_hood_id.cleanest
        puts "#{clean.bathroom.name}, #{clean.bathroom.address}"
          else puts "Sorry, there no reviews in this neighborhood."
          end
         sleep(3)
         what_to_do_menu
    end

    def wait_helper
        if short = @chosen_hood_id.short_wait
        puts "#{short.bathroom.name}, #{short.bathroom.address}"
        else puts "Sorry, there are no reviews in this neighborhood."
        end
        sleep(3)
        what_to_do_menu
    end

    def h_helper
        # binding.pry
        handi = @chosen_hood_id.handicap_access
            handi.each{|review| puts "#{review.bathroom.name}, #{review.bathroom.address}"}.uniq
        
    #    puts "#{handi.bathroom.name}, #{handi.bathroom.address}"
    #     else puts "Sorry, there are no handicap accessible bathroons in this neighborhood."
    #     end
       sleep(3)
       what_to_do_menu
    end

    def b_helper
        b = @chosen_hood_id.baby_station
            b.each{|review| puts "#{review.bathroom.name}, #{review.bathroom.address}"}.uniq
        
        # else puts "Sorry, there are no baby changing stations in this neighborhood"
        # end
        sleep(3)
        what_to_do_menu
    end
    
    def exit_helper
        system 'clear'
        puts "Bye, have a wonderful time!"
        puts "🧻 🧻 🧻 🧻 🧻 🧻 🧻 🧻"
        sleep (2)

    end

end
