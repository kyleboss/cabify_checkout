module Exceptions
  class InvalidQuantityException < StandardError; end
  class NANQuantityException < InvalidQuantityException; end
  class NegativeQuantityException < InvalidQuantityException; end
  class ProductDoesNotExistException < StandardError; end
end