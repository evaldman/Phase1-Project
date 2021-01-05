User.destroy_all
User.reset_pk_sequence
Bathroom.destroy_all
Bathroom.reset_pk_sequence
Neighborhood.destroy_all
Neighborhood.reset_pk_sequence
Review.destroy_all
Review.reset_pk_sequence

########################

#users
puts "creating users"

melissa = User.create(name: "Melissa")
billy = User.create(name: "Billy")
eric = User.create(name: "Eric")
timmy = User.create(name: "Timmy")
whitney = User.create(name: "Whitney")
cameron = User.create(name: "Cameron")
kim = User.create(name: "Kim")
julia = User.create(name: "Julia")

#neighborhoods
puts "creating neighborhoods"

soho = Neighborhood.create(name: "SOHO")
chinatown = Neighborhood.create(name: "Chinatown")
west_village = Neighborhood.create(name: "West Village")
les = Neighborhood.create(name: "Lower East Side")
midtown = Neighborhood.create(name: "Midtown")
koreatown = Neighborhood.create(name: "Koreatown")
upper_east_side = Neighborhood.create(name: "Upper East Side")
harlem = Neighborhood.create(name: "Harlem")

#bathrooms
mcdonalds = Bathroom.create(name: "Mcdonalds", address: "262 Canal st", neighborhood_id: chinatown.id)
starbucks = Bathroom.create(name: "Starbucks", address: "1491 Lexington ave", neighborhood_id: upper_east_side.id)
sweetgreen = Bathroom.create(name: "Sweetgreen", address: "781 Broadway", neighborhood_id: midtown.id)
law_firm = Bathroom.create(name: "Law Firm", address: "131 E 36th st 45th floor", neighborhood_id: midtown.id)
equinox = Bathroom.create(name: "Equinox", address: "170 E 156th st", neighborhood_id: harlem.id)
sallys = Bathroom.create(name: "Sallys", address: "21 Eldridge st", neighborhood_id: les.id)
bryant_park = Bathroom.create(name: "Bryant Park", address: "55 W 40th st", neighborhood_id: midtown.id)
radio_star_karaoke = Bathroom.create(name: "Radio Star Karaoke", address: "3 W 35th st", neighborhood_id: koreatown.id)

# reviews

# = Review.create(cleanliness: , flush_factor: , security_level: , wait_time: , handicap_accessible: , baby_changing_station: , user_id: , bathroom_id: )

review1 = Review.create(cleanliness: 7, flush_factor: "jet engine", security_level: "high", wait_time: 11, handicap_accessible: 1, baby_changing_station: 0, user_id: melissa.id, bathroom_id: mcdonalds.id)
review2 = Review.create(cleanliness: 3, flush_factor: "lazy river", security_level: "low", wait_time: 6, handicap_accessible: 0, baby_changing_station: 0, user_id: billy.id, bathroom_id: starbucks.id)
review3 = Review.create(cleanliness: 2, flush_factor: "mild current", security_level: "medium", wait_time: 2, handicap_accessible: 1, baby_changing_station: 1, user_id: eric.id, bathroom_id: bryant_park.id)
review4 = Review.create(cleanliness: 10, flush_factor: "jet engine", security_level: "high", wait_time: 4, handicap_accessible: 1, baby_changing_station: 1, user_id: julia.id, bathroom_id: equinox.id)
review5 = Review.create(cleanliness: 8, flush_factor: "mid current", security_level: "low", wait_time: 15, handicap_accessible: 0, baby_changing_station: 0, user_id: kim.id, bathroom_id: sallys.id)
review6 = Review.create(cleanliness: 2, flush_factor: "lazy river", security_level: "low", wait_time: 9, handicap_accessible: 0, baby_changing_station: 1, user_id: timmy.id, bathroom_id: bryant_park.id)
review7 = Review.create(cleanliness: 1, flush_factor: "mild current", security_level: "high", wait_time: 7, handicap_accessible: 0, baby_changing_station: 1, user_id: whitney.id, bathroom_id: sallys.id)
review8 = Review.create(cleanliness: 10, flush_factor: "mild current", security_level: "high", wait_time: 7, handicap_accessible: 0, baby_changing_station: 1, user_id: whitney.id, bathroom_id: starbucks.id)
review9 = Review.create(cleanliness: 1, flush_factor: "jet engine", security_level: "high", wait_time: 7, handicap_accessible: 0, baby_changing_station: 1, user_id: whitney.id, bathroom_id: bryant_park.id)
review10 = Review.create(cleanliness: 1, flush_factor: "mild current", security_level: "high", wait_time: 7, handicap_accessible: 0, baby_changing_station: 1, user_id: whitney.id, bathroom_id: sallys.id)

puts "🔥 🔥 🔥 🔥 "

#      t.integer "cleanliness"
#     t.string "flush_factor"
#     t.string "security_level"
#     t.integer "wait_time"
#     t.boolean "handicap_accessible"
#     t.boolean "baby_changing_station"