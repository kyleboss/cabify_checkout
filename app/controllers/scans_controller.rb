# frozen_string_literal: true

# Controller for scans. Typically will only be called from React.
class ScansController < ApplicationController
  before_action :set_scan, only: %i[update destroy]
  # POST /scans
  # POST /scans.json
  def create
    checkout = scan_params[:checkout_id] ? Checkout.find(scan_params[:checkout_id]) : Checkout.create!
    @scan = checkout.scan(scan_params[:product_identifier], scan_params[:quantity], false)

    if @scan.save
      render json: CheckoutState.new(@scan), status: :created
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    if (scan_params[:quantity].to_i.positive? && @scan.update(quantity: scan_params[:quantity])) ||
       (scan_params[:quantity].to_i.zero? && @scan.destroy)
      render json: CheckoutState.new(@scan), status: :ok, location: @scan
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    checkout = @scan.checkout
    @scan.destroy
    render json: CheckoutState.new(checkout), status: :ok, location: @scan
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scan
    @scan = Scan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scan_params
    params.permit(:product_id, :checkout_id, :product_identifier, :scan, :authenticity_token, :quantity)
  end
end
