class Interface

    attr_reader :prompt
    attr_accessor :user, :bathroom

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
        user = User.find_by(name: name, password: password)
        puts "Welcome #{user.name}, please select your neighborhood"
        sleep(2)
        hoods = Neighborhood.all_names
        chosen_hood_id = prompt.select("Which neighborhood are you in?", hoods)
        what_to_do_menu
        # neighborhood_menu
    end

    # def neighborhood_menu
    #     hoods = Neighborhood.all_names
    #     chosen_hood_id = prompt.select("Which neighborhood are you in?, hoods")
    #     what_to_do_menu
    # end
    def what_to_do_menu
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Find a bathroom", -> { bathroom_helper}
            menu.choice "Leave a review", -> { review_helper }
        end
            
    end

    def bathroom_helper
        
    end

    def review_helper
        cleanliness = prompt.ask("How clean was this bathroom?").to_i
        flush_factor = prompt.ask("Flush type? jet engine, mild current, lazy river")
        security_level = prompt.ask("is there security? low, medium, high")
        wait_time = prompt.ask("How many minutes did you wait?").to_i
        handicap_accessible = prompt.yes?("Was there handicap access?")
        baby_changing_station = prompt.yes?("Was there a baby changing station?")
    end

end
