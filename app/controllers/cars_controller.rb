class CarsController < ApplicationController
  before_action :set_car, only: %i[ show update destroy ]

  # GET /cars
  def index
    @cars = Rails.cache.fetch("car:index", expires_in: 2.minutes) do
      puts "Buscando no banco!!"
      Car.all.to_a
    end 
    render json: @cars
  end

  # GET /cars/1
  def show
    @car = Rails.cache.fetch("car:#{params[:id]}", expires_in: 5.minutes) do
      puts "Buscando no banco!!"
      Car.find(params[:id])
    end 
    render json: @car
  end

  # POST /cars
  def create
    @car = Car.new(car_params)

    if @car.save
      Rails.cache.delete("car:index")
      render json: @car, status: :created
    else
      render json: @car.errors
    end
  end

  # PATCH/PUT /cars/1
  def update
    if @car.update(car_params)
      Rails.cache.delete("car:#{params[:id]}")
      Rails.cache.delete("car:index")
      render json: @car
    else
      render json: @car.errors
    end
  end

  # DELETE /cars/1
  def destroy
    Rails.cache.delete("car:#{params[:id]}")
    Rails.cache.delete("car:index")
    @car.destroy!
    render json: { message: "Car deleted successfully" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.expect(car: [ :brand_id, :model, :year, :price, :mileage, :color, :status ])
    end
end
