# frozen_string_literal: true

# This kind of product will give a certain number of products every time the user buys a predetermined number of that
# product.
#
# Some key validations made off of logical assumptions:
# The number of free items received for a given X should be > 0. It would technically be a standard product otherwise.
# The number of items the shopper must buy should be > the number of items they will get for free, or else the product
# would technically be free.
class BuyXGetXProduct < Product
  validates_numericality_of :num_will_get, greater_than: 0
  validates_numericality_of :num_to_buy, greater_than: :num_will_get
  validates_presence_of :num_will_get, :num_to_buy

  private

  # Determines the cost of the product given the amount is purchased.
  #
  # Note: if quantity is 0, we find ourselves in the holes of the matrix. We will just return the base price in that
  # case.
  def price_per_unit(quantity = 1)
    return base_price if quantity.zero?
    num_free_units = num_units_received_free(quantity)
    (base_price * (quantity - num_free_units)) / quantity
  end

  # The number of products that the shopper will receive for free, given that they purchase X products.
  #
  # Note: We do not have to worry about num_to_buy being 0, since we check that in the validations. But hey..we can
  # never be too careful, right?
  def num_units_received_free(quantity)
    return 0 if num_to_buy.zero?
    (quantity/num_to_buy) * num_will_get
  end
end
