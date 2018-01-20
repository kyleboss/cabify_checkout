# frozen_string_literal: true

class ScansController < ApplicationController
  before_action :set_scan, only: %i[show edit update destroy]

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  # GET /scans/1
  # GET /scans/1.json
  def show; end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit; end

  # POST /scans
  # POST /scans.json
  def create
    checkout = scan_params[:checkout_id] ? Checkout.find(scan_params[:checkout_id]) : Checkout.create!
    @scan = checkout.scan(scan_params[:product_identifier], scan_params[:quantity])

    if @scan.save
      render json: CheckoutState.new(@scan), status: :created
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    if @scan.update({quantity: scan_params[:quantity]})
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
