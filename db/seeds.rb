# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# imports car brands and models
require 'csv'

CSV.foreach('db/car_types.csv') do |row|
  brand = CarBrand.find_or_create_by(cn_name: row[1])
  brand.car_models.find_or_create_by cn_name: row[4].gsub(row[1], '')
end

CSV.foreach('db/car_logos.csv') do |row|
  brand = CarBrand.find_or_create_by cn_name: row[1]
  brand.update img_url: row[2]
end
