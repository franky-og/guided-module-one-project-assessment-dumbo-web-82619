class User < ActiveRecord::Base
    has_many :reservations
    has_many :restaurants, through: :reservations

    # attr_accessor :interface

    def self.tty_prompt
       prompt = TTY::Prompt.new
    end
    
    def self.handle_new_user
        system "clear"
        name = self.tty_prompt.ask("What is your name?")
        User.create(name: name)
    end

    def self.handle_returning_user
        system "clear"
        name = self.tty_prompt.ask("What is your name?")
        User.find_by(name: name)
    end

    def view_user_reservations
        self.reservations.map do |reservation| 
            puts "Restaurant: #{reservation.restaurant.name}"
            puts "Time: #{reservation.time}"
            puts "Date: #{reservation.date}"
            puts "Party Size: #{reservation.party_size}"
            puts "Reservation Number: #{reservation.id}"
        end
    end

    # # def view_user_restaurants
    #     restaurant_names_array = self.restaurants.each do |restaurant|
    #         puts restaurant.name
    #     end
    #     # puts restaurant_names_array
    # end 


    
        
end