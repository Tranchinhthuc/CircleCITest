# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# User.create! full_name: "tran chinh thuc", email: "thuctc91@gmail.com", password: "12341234", role: "admin"
# User.create! full_name: "Le Quang", email: "quang@gmail.com", password: "12341234", role: "admin"

["Hà Nội", "Hồ Chí Minh", "An Giang", "Bạc Liêu", "Bắc Giang", "Bắc Ninh"].each.with_index do |city_name, index|
  city = City.create(name: city_name, order_number: index+1, description: "Description for #{city_name}")
  10.times do |i|
    city.districts.create(name: "#{city_name}_district_#{i+1}", order_number: i+1, description: "Description for #{city_name}_district_#{i+1}")
  end
end

10.times do |i|
  Service.create(name: "Service_#{i+1}", description: "Description for Service_#{i+1}")
  Bank.create(name: "Bank_#{i+1}", description: "Description for Bank_#{i+1}")
end
