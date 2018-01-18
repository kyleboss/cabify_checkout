# frozen_string_literal: true

# A Scan represents, in the physical world, the barcode scanner scanning a product. In the data world, it maps a
# Checkout with a specific product. There is a quantity column, if a product is scanned multiple times for a Checkout,
# we simply increment the quantity to save on space & calculation time.
#
# We are going to kindly assume here that quantity cannot be a decimal, & it must be greater than 0!
class Scan < ApplicationRecord
  belongs_to :product
  belongs_to :checkout
  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  # Calculates the total cost of this scan. Generally will be called by Checkout#total
  def total_cost(currency = :EUR)
    product.total_cost(quantity, currency)
  end
end
