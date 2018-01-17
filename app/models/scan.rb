# frozen_string_literal: true

# A Scan represents, in the physical world, the barcode scanner scanning a product. In the data world, it maps a
# checkout with a specific product. There is a quantity column, if a product is scanned multiple times for a checkout,
# we simply increment the quantity to save on space & calculation time.
class Scan < ApplicationRecord
  belongs_to :product
  belongs_to :checkout
  validates_numericality_of :quantity, only_integer: true, greater_than_or_equal_to: 0

  def total_cost
    product.total_cost(quantity)
  end
end