# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




Island.create([
   {name: "Ile de Dawn"},
 {image: "https://i.pinimg.com/736x/ca/a6/c1/caa6c130f4eb108d4f0774574c1acfbf.jpg"},
 {category: "East Blue"},
 {difficulty: 1},
 {condition: ""},
 {position: 0}]
  )

Place.create([
 {name: "Village de Fuchsia"},
 {image: "http://ekladata.com/NENTzGt4Cg3N9N71OfCPyLCaF3I.jpg"},
 {island_id: 1},
 {condition: ""}])
