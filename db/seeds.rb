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
westvillage = Neighborhood.create(name: "West Village")
les = Neighborhood.create(name: "Lower East Side")
midtown = Neighborhood.create(name: "Midtown")
koreatown = Neighborhood.create(name: "Koreatown")
upper_east_side = Neighborhood.create(name: "Upper East Side")
harlem = Neighborhood.create(name: "Harlem")

#bathrooms
mcdonalds = Bathroom.create(name: "Mcdonalds", address: "262 Canal st", neighborhood_id: chinatown.id)

puts "🔥 🔥 🔥 🔥 "