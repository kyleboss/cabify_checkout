# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :set_checkout, only: :update

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
    @all_products = Product.all.as_json
    @base_url = Rails.env.development? ? 'http://localhost:3000' : 'http://cabifycheckout.com'
    @all_currencies = ExchangeRateService.valid_currencies
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)

    if @checkout.save
      render json: CheckoutState.new(@checkout), status: :created
    else
      render json: @checkout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /checkouts/1
  # PATCH/PUT /checkouts/1.json
  def update
    if @checkout.update(checkout_params)
      render json: CheckoutState.new(@checkout), status: :ok
    else
      render json: @checkout.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_checkout
    @checkout = Checkout.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def checkout_params
    params.require(:checkout).permit(:currency)
  end
end
