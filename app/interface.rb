class Interface

    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
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
