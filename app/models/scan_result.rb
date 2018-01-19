# frozen_string_literal: true

class ScanResult
  attr_reader :checkout_id, :scanned_products, :currency
  def initialize(update_obj)
    checkout = if update_obj.is_a? Scan
                 @checkout_id = update_obj.checkout_id
                 Checkout.find(@checkout_id)
               else
                 @checkout_id = update_obj.id
                 update_obj
               end
    @currency = ExchangeRateService.valid_currencies.select { |c| c[:code] == checkout.currency.downcase.to_sym }.first
    scans = checkout.scans
    @scanned_products = scans.map do |scan|
      { quantity: scan.quantity, title: scan.product.title, image_url: scan.product.image_url, scan_id: scan.id }
    end
    @cart_summary = {
      charges: scans.map do |scan|
        {
          title: scan.product.title,
          quantity: scan.quantity,
          amount: format('%.2f', scan.total_cost(use_discount: false))
        }
      end,
      discounts: scans.map do |scan|
                   product = scan.product
                   next unless product.is_a?(BuyXGetXProduct) || product.is_a?(BulkProduct)
                   discount_total = scan.discount_total
                   next unless discount_total > 0
                   discount_title = if scan.product.is_a? BuyXGetXProduct
                                      "Buy #{product.num_to_buy} #{product.title.pluralize} Get #{product.num_will_get}"
                                    else
                                      "#{product.title} Bulk Purchase"
                                    end
                   { title: discount_title, amount: format('%.2f', discount_total) }
                 end.compact,
      total: format('%.2f', checkout.total)
    }
  end
end
