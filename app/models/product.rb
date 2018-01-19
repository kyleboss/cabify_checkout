# frozen_string_literal: true

# Product represents a given product whose barcode will be scanned.
#
# We are going to validate that:
#
# the base_price > 0, otherwise we run the risk of giving the shopper money. Ooh lala.
class Product < ApplicationRecord
  validates_numericality_of :base_price, greater_than_or_equal_to: 0
  validates_presence_of :title, :image_url, :base_price, :barcode_number
  has_many :scans
  has_many :checkouts, through: :scans

  # Obtains a product given either the barcode number or the name. Returns nil if there is no match
  def self.retrieve_product(identifier)
    Product.where(barcode_number: identifier.to_s).or(Product.where(title: identifier.to_s)).first
  end

  # Calculates the total cost of this product for the quantity provided for the given currency
  def total_cost(quantity = 1, currency = :EUR, use_discount = true)
    raise Exceptions::NegativeQuantity if quantity.negative?
    raise Exceptions::InvalidCurrency unless ExchangeRateService.valid_currency?(currency)
    ind_price = use_discount ? price_per_unit(quantity) : base_price
    quantity * ind_price * ExchangeRateService.exchange_rate(base_currency.to_sym.upcase, currency.to_sym.upcase)
  end

  private

  # Determines the cost of the product given the amount is purchased. We don't use quantity here, but inheriters do.
  def price_per_unit(_quantity = 1)
    base_price
  end
end
