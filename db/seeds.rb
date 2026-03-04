toyota = Brand.find_or_create_by!(name: "Toyota") { |b| b.country = "Japan" }
bmw = Brand.find_or_create_by!(name: "BMW") { |b| b.country = "Germany" }
honda = Brand.find_or_create_by!(name: "Honda") { |b| b.country = "Japan" }

Car.find_or_create_by!(model: "Corolla", brand_id: toyota.id) do |car|
  car.year = 2022
  car.price = 120000.00
  car.mileage = 15000
  car.color = "White"
  car.status = :available
end

Car.find_or_create_by!(model: "M3", brand_id: bmw.id) do |car|
  car.year = 2023
  car.price = 180000.00
  car.mileage = 5000
  car.color = "Black"
  car.status = :available
end

Car.find_or_create_by!(model: "Civic", brand_id: honda.id) do |car|
  car.year = 2021
  car.price = 95000.00
  car.mileage = 25000
  car.color = "Silver"
  car.status = :available
end