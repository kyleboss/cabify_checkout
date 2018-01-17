# frozen_string_literal: true

# Product represents a given product whose barcode will be scanned.
class Product < ApplicationRecord
  validates_numericality_of :base_price, greater_than_or_equal_to: 0

  # Obtains a product given either the barcode number or the name. Returns nil if there is no match
  def self.retrieve_product(identifier)
    Product.where(barcode_number: identifier.to_s).or(Product.where(title: identifier.to_s)).first
  end

  # Calculates the total cost of this product for the quantity provided for the given currency
  def total_cost(quantity = 1, currency = :EUR)
    raise Exceptions::NegativeQuantity if quantity.negative?
    raise Exceptions::InvalidCurrency unless ExchangeRateService.valid_currency?(currency)
    quantity * base_price * ExchangeRateService.exchange_rate(base_currency.to_sym, currency.to_sym)
  end
end
