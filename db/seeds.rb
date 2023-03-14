# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

data = [{ id: 1, name: 'Arisha Barron' },
        { id: 2, name: 'Branden Gibson' },
        { id: 3, name: 'Rhonda Church' },
        { id: 4, name: 'Georgina Hazel' }]

data.each_with_index do |user, index|
  User.create(name: user[:name], email: 'email' + index.to_s + '@email.com', password: 'random')
end
