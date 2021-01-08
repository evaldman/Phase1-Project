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
        password = prompt.mask("Enter Password")
        unless User.find_by(name: name, password: password)
            puts "Sorry name or password does not match".colorize(:red)
            name = prompt.ask("Enter Name")
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
            menu.choice "Leave a Review", -> { review_helper }
            menu.choice "Delete a Review", -> { delete_review_helper }
            menu.choice "Update Review", -> { update_review_helper }
            menu.choice "Delete Account", -> { delete_account }
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
        #exit
    end

    def review_helper
        system 'clear'
        # @user.reload
        hood_bathroom = @chosen_hood_id.all_bathrooms
        selected_bathroom = prompt.select("Please select a bathroom", hood_bathroom)
        cleanliness = prompt.ask("How clean was this bathroom?").to_i
        flush_factor = prompt.ask("Flush type? jet engine, mild current, lazy river")
        security_level = prompt.ask("is there security? low, medium, high")
        wait_time = prompt.ask("How many minutes did you wait?").to_i
        handicap_accessible = prompt.yes?("Was there handicap access?")
        baby_changing_station = prompt.yes?("Was there a baby changing station?")
        # binding.pry
        Review.create(cleanliness: cleanliness, flush_factor: flush_factor, security_level: security_level, handicap_accessible: handicap_accessible, baby_changing_station: baby_changing_station, user_id: @user.id, bathroom_id: selected_bathroom.id)
        puts "Thanks for your review #{@user.name}, please come back soon!"
    end

    def delete_review_helper
        hood_bathroom = @chosen_hood_id.all_bathrooms
        selected_bathroom = prompt.select("Please select a bathroom", hood_bathroom)

    end

    def update_review_helper
        user_review = @user.user_reviews
        # binding.pry

        #display all user bathrooms#user_review_name = user_review.map{}  ---> user_review[0].bathroom.name
        #user selects the review#user_bathroom_name from tty::prompt
        #update only the selected review#

        selected_review = prompt.select("Select a review", user_review.map{|review| review.bathroom.address})
        choices = {cleanliness: 1, flush_Factor: 2, wait_Time: 3, handicap_accessible: 4, baby_changing_station: 5}

        usr_sel_rev =  user_review.find{|review| review.bathroom.address == selected_review}
        val = prompt.select("which feature would you like to edit?", choices)
        if val == 1
            # binding.pry
            
            up_cleanliness = prompt.ask("How clean was this bathroom?").to_i
            # @selected_review.cleanliness = up_cleanliness
            usr_sel_rev.update(cleanliness: up_cleanliness)
            # binding.pry
            system('clear')
            what_to_do_menu
        elsif val == 2
            up_flush_factor = prompt.ask("Flush type? jet engine, mild current, lazy river")
            usr_sel_rev.update(flush_factor: up_flush_factor)
            system('clear')
            what_to_do_menu
        elsif val == 3
            up_security_level = prompt.ask("is there security? low, medium, high")
            usr_sel_rev.update(security_level: up_security_level)
            system('clear')
            what_to_do_menu
        elsif val == 4
            up_wait_time = prompt.ask("How many minutes did you wait?").to_i
            usr_sel_rev.update(wait_time: up_wait_time)
            system('clear')
            what_to_do_menu
        elsif val == 5
            up_handicap_accessible =  prompt.yes?("Was there handicap access?")
            usr_sel_rev.update(handicap_accessible: up_handicap_accessible)
            system('clear')
            what_to_do_menu
        elsif val == 6
            up_baby_changing_station =  prompt.yes?("Was there a baby changing station?")
            usr_sel_rev.update(baby_changing_station: up_baby_changing_station)
            system('clear')
            what_to_do_menu
        else 
            what_to_do_menu
        end
    end

    def delete_account

    end
    
    def exit_helper
        puts "🧻🧻🧻🧻🧻🧻🧻🧻"
        sleep (2)

    end

end
