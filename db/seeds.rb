# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



puts "Destroy all instances"
Question.destroy_all

puts "creating questions"

traitre_wano = Question.create!(
    title: 'Qui à trahi les fourreaux rouges en renseignant Orochi de leurs actions?',
    tag: 'wano',
    photo: "https://res.cloudinary.com/dsiamykrd/image/upload/v1577443578/wano_gtoynb.jpg"
  )
  traitre_wano.photo = "https://res.cloudinary.com/dsiamykrd/image/upload/v1577443578/wano_gtoynb.jpg"

puts "creating answers"

answer_1_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Kanjuro?',
  multiplier: 2,
  status: 'unknow',
  position: 1,
  )

answer_2_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Shinobu?',
  multiplier: 2,
  status: 'unknow',
  position: 2,
  )

answer_3_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Carrot?',
  multiplier: 3,
  status: 'unknow',
  position: 3,
  )

answer_4_traitre_wano = Answer.create!(
  question: traitre_wano,
  text: 'Autre?',
  multiplier: 2,
  status: 'unknow',
  position: 4,
  )
