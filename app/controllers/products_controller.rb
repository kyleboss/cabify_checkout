# frozen_string_literal: true

# Products controller is mostly used by the Admin Panel to see all products, update, destroy, & add new ones.
class ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy]

  # GET /products
  # GET /products.json
  def index
    @all_products = Product.all.as_json
    @all_currencies = ExchangeRateService.valid_currencies
    @base_url = Rails.env.development? ? 'http://localhost:3000' : 'http://cabifycheckout.com'
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_args)

    if @product.save
      render json: Product.all, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if (!product_params[:is_removal] && @product.update(product_args)) ||
       (product_params[:is_removal] && @product.destroy)
      render json: Product.all, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_args
    {
        title: product_params[:title],
        base_price: product_params[:base_price],
        base_currency: product_params[:base_currency],
        barcode_number: product_params[:barcode_number],
        image_url: product_params[:image_url],
        num_to_buy: product_params[:num_to_buy],
        num_will_get: product_params[:num_will_get],
        bulk_threshold: product_params[:bulk_threshold],
        bulk_price: product_params[:bulk_price],
        type: product_params[:type]
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.permit(:title, :base_price, :base_currency, :barcode_number, :image_url, :num_to_buy,
                  :num_will_get, :bulk_threshold, :bulk_price, :is_removal, :authenticity_token, :id, :type).permit!
  end
end
