class Scan < ApplicationRecord
  belongs_to :product
  belongs_to :checkout
end
