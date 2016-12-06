# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# imports car brands and models
require 'csv'

CSV.foreach('db/car_brands.csv') do |row|
  CarBrand.find_or_create_by(id: row[0], cn_name: row[1], img_url: row[2])
end

CSV.foreach('db/car_models.csv') do |row|
  brand = CarBrand.find row[0]
  brand.car_models.create cn_name: row[1]
end
