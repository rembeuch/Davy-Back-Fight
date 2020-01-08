# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



puts "Destroy all instances"
UserAnswer.destroy_all
Answer.destroy_all
Question.destroy_all
Order.destroy_all
Product.destroy_all


puts "creating questions"

traitre_wano = Question.create!(
    closed: false,
    title: 'Qui à trahi les fourreaux rouges en renseignant Orochi de leurs actions?',
    tag: 'wano',
  )
  traitre_wano.photo = "https://res.cloudinary.com/dsiamykrd/image/upload/v1577443578/wano_gtoynb.jpg"

puts "creating answers"

answer_1_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Kanjuro',
  multiplier: 2,
  status: 'En cours',
  position: 1,
  )

answer_2_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Shinobu',
  multiplier: 2,
  status: 'En cours',
  position: 2,
  )

answer_3_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Carrot',
  multiplier: 3,
  status: 'En cours',
  position: 3,
  )

answer_4_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Autre',
  multiplier: 2,
  status: 'En cours',
  position: 4,
  )


puts 'Creating products...'
Product.create!(name: 'Poster Luffy', price_cents: 900, photo_url: 'https://cdn.shopify.com/s/files/1/0093/9143/9935/products/Poster_One_piece_luffy_-_Luffy_store_-min_1200x1200.jpg?v=1564828804')

Product.create!(name: 'Poster Zoro', price_cents: 900, photo_url: 'https://cdn11.bigcommerce.com/s-c90z0hdhmk/images/stencil/1280x1280/products/52/54/zoro_wanted__67101.1556392879.jpg?c=2&imbypass=on')
