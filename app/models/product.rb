class Product < ApplicationRecord
  def self.retrieve_product(identifier); end

  def total_cost(quantity = 1)
    0
  end
end