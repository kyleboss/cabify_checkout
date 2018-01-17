# frozen_string_literal: true

# Custom exceptions used to get out of a sticky situation
module Exceptions
  class InvalidCurrency < StandardError; end
  class NegativeQuantity < StandardError; end
end
