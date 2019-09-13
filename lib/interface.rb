class Interface
    attr_accessor :prompt, :user, :restaurant

    def initialize
        @prompt = TTY::Prompt.new
    end


    def welcome
        system "clear"
        puts "Welcome!"
        self.prompt.select("Person or Restaurant?") do |menu|
        # binding.pry
            menu.choice "Person", ->{self.handle_user}
        menu.choice "Restaurant", ->{self.handle_restaurant}
        menu.choice "Exit", ->{exit} 
        end
    end

    def handle_user 
        system "clear"
        self.prompt.select("Are you a new or returning User?") do |menu|
          menu.choice "New User", -> {User.handle_new_user}
          menu.choice "Returning User", -> {User.handle_returning_user}
          menu.choice "Back", ->{self.welcome}
        end
    end

    def handle_restaurant
        system "clear"
        self.prompt.select("Press Enter") do |menu|
        menu.choice "Restaurant", -> {Restaurant.handle_returning_restaurant}
        menu.choice "Back", ->{self.welcome}
        end
    end

    def user_main_menu
        self.user.reload
        puts "Welcome #{user.name}!" 
        prompt.select("What would you like to do?") do |menu|
            menu.choice "Create Reservation", ->{create_reservation}
            menu.choice "View Reservation(s)", ->{user.view_user_reservations}
            menu.choice "Update Reservation", ->{update_user_reservation}
            menu.choice "Cancel Reservation", ->{cancel_user_reservation}
            menu.choice "Back", ->{self.welcome}
            menu.choice "Exit", ->{self.art}
        end
    end

    def restaurant_main_menu
        self.restaurant.reload
        puts "Welcome #{restaurant.name}!" 
            prompt.select("What would you like to do?") do |menu|
            menu.choice "View Reservation(s)", ->{restaurant.view_restaurant_reservations}
            menu.choice "Update Reservation", ->{update_restaurant_reservation}
            menu.choice "Cancel Reservation", ->{cancel_restaurant_reservation}
            menu.choice "Back", ->{self.welcome}
            menu.choice "Exit", ->{self.art}
        end
    end
    
    def create_reservation
       restaurant_name = prompt.select("What restaurant would you like to reserve?") do |menu|
            menu.choice "Kenka", ->{Restaurant.first}
            menu.choice "Misoya", ->{Restaurant.second}
            menu.choice "Udon West", ->{Restaurant.third}
            menu.choice "Masa", ->{Restaurant.fourth}
            menu.choice "Tetsu", ->{Restaurant.fifth}
            menu.choice "Sushi Nakazawa", ->{Restaurant.last}
            menu.choice "Back", ->{self.user_main_menu}
        end
        party_size = prompt.ask("How many people are in your party? (Ex: 5)")
        date = prompt.ask("What date would you like to reserve? (Ex: 01-01-11)")
        time = prompt.ask("What time would you like to reserve? (Ex: 09:00pm)")
        reservation_instance = Reservation.create(user: user, restaurant: restaurant_name, time: time, date: date, party_size: party_size)
        binding.pry
        puts "Customer Name: #{user.name}"
        puts "Restaurant: #{restaurant_name.name}"
        puts "Time: #{time}"
        puts "Date: #{date}"
        puts "Party Size: #{party_size}"
        puts "Reservation Number: #{reservation_instance.id}"
        sleep 7
        self.no_end_user
    end

    def update_user_reservation
        user_reservations_array = self.user.reservations.map do |reservation| reservation.id
        end
        user.view_user_reservations #displays all user reservations
        reservation_change_choice = self.prompt.select("Which reservation would you like to change?", user_reservations_array) 
        prompt.select("What would you like to change?") do |menu|
            menu.choice "Edit Time", ->{user_update_time(reservation_change_choice)}
            menu.choice "Edit Date", ->{user_update_date(reservation_change_choice)}
            menu.choice "Edit Party Size", ->{user_update_party_size(reservation_change_choice)}
            menu.choice "Back", ->{self.user_main_menu}
        end
    end

    def update_restaurant_reservation
        restaurant_reservations_array = self.restaurant.reservations.map do |reservation| reservation.id
        end
        restaurant.view_restaurant_reservations
        reservation_change_choice = self.prompt.select("Which reservation would you like to change?", restaurant_reservations_array) 
        prompt.select("What would you like to change?") do |menu|
            menu.choice "Edit Time", ->{restaurant_update_time(reservation_change_choice)}
            menu.choice "Edit Date", ->{restaurant_update_date(reservation_change_choice)}
            menu.choice "Edit Party Size", ->{restaurant_update_party_size(reservation_change_choice)}
            menu.choice "Back", ->{self.restaurant_main_menu}
        end
    end

    def user_update_time(reservation_id_choice)
        new_time = prompt.ask("What time would you like to change your reservation to? (Ex: 09:00pm)")
        Reservation.find_by(id: reservation_id_choice).update_attribute(:time, new_time)
        puts "Your new scheduled time is #{new_time}"
        sleep 4
        self.no_end_user
       
    end
       
    def user_update_date(reservation_id_choice)
        new_date = prompt.ask("What date would you like to change your reservation to? (Ereservation_id_choice: 01-01-11)")
         Reservation.find_by(id: reservation_id_choice).update_attribute(:date, new_date)
         puts "Your new scheduled date is #{new_date}"
         sleep 4
         self.no_end_user
         
     end

    def user_update_party_size(reservation_id_choice)
        new_party_size = prompt.ask("What is your new party size?")
         Reservation.find_by(id: reservation_id_choice).update_attribute(:party_size, new_party_size)
         puts "Your updated party size is #{new_party_size}"
         sleep 4
         self.no_end_user
         
    end

    def restaurant_update_time(reservation_id_choice)
        new_time = prompt.ask("What time would you like to change your reservation to? (Ex: 09:00pm)")
        Reservation.find_by(id: reservation_id_choice).update_attribute(:time, new_time)
        puts "Your new scheduled time is #{new_time}"
        sleep 4
        self.no_end_restaurant
       
    end
       
    def restaurant_update_date(reservation_id_choice)
        new_date = prompt.ask("What date would you like to change your reservation to? (Ereservation_id_choice: 01-01-11)")
         Reservation.find_by(id: reservation_id_choice).update_attribute(:date, new_date)
         puts "Your new scheduled date is #{new_date}"
         sleep 4
         self.no_end_restaurant
         
     end
    
    def restaurant_update_party_size(reservation_id_choice)
        new_party_size = prompt.ask("What is your new party size?")
         Reservation.find_by(id: reservation_id_choice).update_attribute(:party_size, new_party_size)
         puts "Your updated party size is #{new_party_size}"
         sleep 4
         self.no_end_restaurant
         
    end

    def cancel_user_reservation
        user_reservations_array = self.user.reservations.map do |reservation| reservation.id
        end
        user.view_user_reservations
        reservation_change_choice = self.prompt.select("Which reservation would you like to cancel?", user_reservations_array)
        Reservation.find_by(id: reservation_change_choice).destroy
        puts "Reservation number #{reservation_change_choice} has been cancelled"
        sleep 4
        self.no_end_user
    end

    def cancel_restaurant_reservation
        restaurant_reservations_array = self.restaurant.reservations.map do |reservation| reservation.id
        end
        restaurant.view_restaurant_reservations
        reservation_change_choice = self.prompt.select("Which reservation would you like to cancel?", restaurant_reservations_array)
        Reservation.find_by(id: reservation_change_choice).destroy
        puts "Reservation number #{reservation_change_choice} has been cancelled"
        sleep 4
        self.no_end_restaurant
    end

    def no_end_user
        self.prompt.select("What would you like to do?") do |menu|
            menu.choice "Main Menu", ->{self.user_main_menu}
            menu.choice "Exit", ->{self.art}
        end
    end

    def no_end_restaurant
        self.prompt.select("What would your restaurant like to do?") do |menu|
            menu.choice "Main Menu", ->{self.restaurant_main_menu}
            menu.choice "Exit", ->{self.art}
        end
    end

    def art
    system "clear"
    art = puts <<-'EOF'
                                              `-.`'.-'
                                       `-.        .-'.
                                    `-.    -./\.-    .-'
                                        -.  /_|\  .-
                                    `-.   `/____\'   .-'.
                                 `-.    -./.-""-.\.-      '
                                    `-.  /< (()) >\  .-'
                                  -   .`/__`-..-'__\'   .-
                                ,...`-./___|____|___\.-'.,.
                                   ,-'   ,` . . ',   `-,
                                ,-'   ________________  `-,
                                   ,'/____|_____|_____\
                                  / /__|_____|_____|___\
                                 / /|_____|_____|_____|_\
                                ' /____|_____|_____|_____\
                              .' /__|_____|_____|_____|___\
                             ,' /|_____|_____|_____|_____|_\
,,---''--...___...--'''--.. /../____|_____|_____|_____|_____\ ..--```--...___...--``---,,
                           '../__|_____|_____|_____|_____|___\
      \    )              '.:/|_____|_____|_____|_____|_____|_\               (    /
      )\  / )           ,':./____|_____|_____|_____|_____|_____\             ( \  /(
     / / ( (           /:../__|_____|_____|_____|_____|_____|___\             ) ) \ \
    | |   \ \         /.../|_____|_____|_____|_____|_____|_____|_\           / /   | |
 .-.\ \    \ \       '..:/____|_____|_____|_____|_____|_____|_____\         / /    / /.-.
(=  )\ `._.' |       \:./ _  _ ___  ____ ____ _    _ _ _ _ _  _ ___\        | `._.' /(  =)
 \ (_)       )       \./  |\/| |__) |___ |___ |___ _X_ _X_  \/  _|_ \       (       (_) /
  \    `----'         """"""""""""""""""""""""""""""""""""""""""""""""       `----'    /
   \   ____\__          __ __    _  __ _     _  __ ________    _____        __/____   /
    \ (=\     \        |_ |\ |V||_)|_ |_)   |_|(_ /   |  |    |_  |        /     /-) /
     \_)_\     \       |__|__| ||  |__| \   | |__)\___|__|_   |  _|_      /     /_(_/
          \     \                                                        /     /
           )     )  _                                                _  (     (
          (     (,-' `-..__                                    __..-' `-,)     )
           \_.-''          ``-..____                  ____..-''          ``-._/
            `-._                    ``--...____...--''                    _.-'
                `-.._                                                _..-'
                     `-..__             ENUMARATI             __..-'
                           ``-..____                  ____..-''
                                    ``--...____...--''
    
    EOF
    art
    end
end
