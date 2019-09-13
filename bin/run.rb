require_relative '../config/environment'

puts "hello world"

cli = Interface.new
user_object = cli.welcome 

while user_object == nil
    user_object = cli.welcome
end

if user_object.class == User
    cli.user = user_object 
    cli.user_main_menu
else
    cli.restaurant = user_object
    cli.restaurant_main_menu
end

