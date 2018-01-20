# frozen_string_literal: true

# This object is primarily used for the React component for Checkouts. The initializer accepts either a Checkout or a
# Scan object. It teases out all of the details that are required to render the Checkout page. It can be thought of as
# a "Presenter" of sorts, if you are familiar with that paradigm.
class CheckoutState
  attr_reader :checkout_id, :scanned_products, :currency
  def initialize(update_obj)
    checkout_obj = checkout(update_obj)
    @checkout_id = checkout_obj.id
    @currency = current_currency(checkout_obj)
    scans = checkout_obj.scans
    @scanned_products = all_scanned_products(scans)
    @cart_summary = {
      charges: all_charges(scans),
      discounts: all_discounts(scans),
      total: priceify_number(checkout_obj.total)
    }
  end

  private

  # Given either a Scan or a Checkout object, returns the Checkout object that is related to it. This is important
  # because the checkout state can either be requested by a new scan or an update to the checkout.
  def checkout(update_obj)
    @_checkout = update_obj.is_a?(Scan) ? update_obj.checkout : update_obj
  end

  # Returns the currency code & symbol for the currency that the checkout uses. Note: This could be more "DRY" if we
  # used ExchangeRateService.valid_currencies, but it would be faster to just re-code the hash and return it instead.
  # Returns nil if does not exist.
  def current_currency(checkout_obj)
    symbol = ExchangeRateService.currency_symbol_mappings[checkout_obj.currency.downcase.to_sym]
    { code: checkout_obj.currency, symbol: symbol }
  end

  # Returns a summary of all the products. This will include quantity, title, image URL, & the scan ID. Primarily used
  # for listing all of the products purchased on the Checkouts page.
  def all_scanned_products(scans)
    scans.map do |scan|
      { quantity: scan.quantity, title: scan.product.title, image_url: scan.product.image_url, scan_id: scan.id }
    end
  end

  # Returns all of the charges that will be displayed in the checkout summary section.
  def all_charges(scans)
    scans.map do |scan|
      {
        title: scan.product.title,
        quantity: scan.quantity,
        amount: priceify_number(scan.total_cost(apply_discount: false))
      }
    end
  end

  # Returns all of the discounts that will be displayed in the checkout summary section.
  def all_discounts(scans)
    scans.map do |scan|
      product = scan.product
      next unless product.is_a?(BuyXGetXProduct) || product.is_a?(BulkProduct)
      discount_total = scan.discount_total
      next unless discount_total.positive?
      { title: discount_title(scan), amount: priceify_number(discount_total) }
    end.compact
  end

  # Creates the discount titles for the discounts that are displayed in the summary section.
  def discount_title(scan)
    if scan.product.is_a? BuyXGetXProduct
      "Buy #{scan.product.num_to_buy} #{scan.product.title.pluralize} Get #{scan.product.num_will_get}"
    else
      "#{scan.product.title} Bulk Purchase"
    end
  end

  # Given an integer or a decimal, it will round it to two decimals (forcefully, even if it is an integer).
  def priceify_number(number)
    format('%.2f', number)
  end
end
