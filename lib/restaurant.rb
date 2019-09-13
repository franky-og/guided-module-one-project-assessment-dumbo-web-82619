class Restaurant < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations

    def self.tty_prompt
        prompt = TTY::Prompt.new
    end
    
    # def self.handle_new_restaurant
    #     name = self.tty_prompt.ask("What is your name?")
    #     Restaurant.create(name: name)
    # end

    
    def self.handle_returning_restaurant
        system "clear"
        restaurant_names = Restaurant.all.each do |restaurant|
            # restaurant.name
        puts "#{restaurant.name}"
        end
        # puts "#{restaurant_names.second}"
        # puts "#{restaurant_names.third}"
        # puts "#{restaurant_names.fourth}"
        # puts "#{restaurant_names.fifth}"
        # puts "#{restaurant_names.last}"
        name = self.tty_prompt.ask("What is your name?")
        self.find_by(name: name)
    end


    
    def view_restaurant_reservations
        self.reservations.map do |reservation| 
            puts "Customer: #{reservation.user.name}"
            puts "Time: #{reservation.time}"
            puts "Date: #{reservation.date}"
            puts "Party Size: #{reservation.party_size}"
            puts "Reservation Number: #{reservation.id}"
        end
    end





end