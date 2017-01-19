namespace :db do
  desc 'update car brands'
  task car_model: :environment do
    require 'csv'

    CSV.foreach 'db/carmodels.csv', headers: true do |r|
      brand = r[1]
      car_brand = CarBrand.find_by cn_name: brand
      unless car_brand
        car_brand = CarBrand.create! cn_name: r[1]
      end
      puts "car brand: #{car_brand.cn_name}"

      model = CarModel.find_by cn_name: r[3]
      unless model
        model = car_brand.car_models.build cn_name: r[3]
      end

      puts "car model: #{model.cn_name}"
      car_brand.save!
    end
  end
end
