User.destroy_all
Restaurant.destroy_all
Reservation.destroy_all
User.reset_pk_sequence
Restaurant.reset_pk_sequence
Reservation.reset_pk_sequence


bob = User.create(name: "Bob")
bill = User.create(name: "Bill")
brad = User.create(name: "Brad")
broseph = User.create(name: "Broseph")

kenka = Restaurant.create(name: "Kenka")
misoya = Restaurant.create(name: "Misoya")
udon_west = Restaurant.create(name: "Udon West")
masa = Restaurant.create(name: "Masa")
tetsu = Restaurant.create(name: "Tetsu")
sushi_nakazawa = Restaurant.create(name: "Sushi Nakazawa")


Reservation.create(user_id: bob.id, restaurant_id: kenka.id, time: "11:00pm", date: "11-05-19", party_size: 5)
Reservation.create(user_id: bob.id, restaurant_id: misoya.id, time: "06:00pm", date: "12-03-19", party_size: 6)
Reservation.create(user_id: bill.id, restaurant_id: udon_west.id, time: "08:00pm", date: "12-19-19", party_size: 10)
Reservation.create(user_id: bill.id, restaurant_id: masa.id, time: "12:00pm", date: "10-16-19", party_size: 2)
Reservation.create(user_id: brad.id, restaurant_id: kenka.id, time: "12:00am", date: "09-24-19", party_size: 11)
Reservation.create(user_id: brad.id, restaurant_id: misoya.id, time: "04:00pm", date: "10-09-19", party_size: 3)
Reservation.create(user_id: broseph.id, restaurant_id: udon_west.id, time: "05:00pm", date: "09-17-19", party_size: 4)
Reservation.create(user_id: broseph.id, restaurant_id: masa.id, time: "07:00pm", date: "10-21-19", party_size: 7)

puts "seeded"