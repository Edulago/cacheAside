class BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show update destroy ]

  # GET /brands
  def index
    @brands = Rails.cache.fetch("brands:index", expires_in: 2.minutes) do
      puts "Buscando no banco!"
      Brand.all.to_a
    end 
    render json: @brands
  end

  # GET /brands/1
  def show
    @brand = Rails.cache.fetch("brands:#{params[:id]}", expires_in: 5.minutes) do
      puts "Buscando no banco!"
      Brand.find(params[:id])
    end
    render json: @brand
  end

  # POST /brands
  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      Rails.cache.delete("brands:index")
      render json: @brand, status: :created
    else
      render json: @brand.errors
    end
  end

  # PATCH/PUT /brands/1
  def update
    if @brand.update(brand_params)
      Rails.cache.delete("brands:#{params[:id]}")
      Rails.cache.delete("brands:index")
      render json: @brand
    else
      render json: @brand.errors
    end
  end

  # DELETE /brands/1
  def destroy
    Rails.cache.delete("brands:#{params[:id]}")
    Rails.cache.delete("brands:index")
    @brand.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.expect(brand: [ :name, :country ])
    end
end
