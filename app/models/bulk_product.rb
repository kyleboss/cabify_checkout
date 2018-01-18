# frozen_string_literal: true

# This kind of product will discount the price of all orders of the same type after it is purchased a certain number of
# times. This 'number of times' is referred to as the threshold before it goes down to the bulk price.
#
# Some key validations made off of logical assumptions:
# The bulk price should be < base price, otherwise it wouldn't be a deal (it might even be the opposite!)
# The bulk threshold should be > 0, otherwise we technically have a normal product, with the bulk price being the base
class BulkProduct < Product
  validates_presence_of :bulk_threshold, :bulk_price
  validates_numericality_of :bulk_price, less_than: :base_price
  validates_numericality_of :bulk_threshold, greater_than: 0

  private

  # Determines the cost of the product given the amount is purchased. This is special for Bulk Product because if the
  # user buys more than the threshold, then the price is toggled to the bulk price instead of the normal base price.
  def price_per_unit(quantity)
    quantity < bulk_threshold ? super : bulk_price
  end
end
