# frozen_string_literal: true

# A Checkout resembles a list of scans. This means a Checkout can have many scans, and can have many products from
# those many scans.
class Checkout < ApplicationRecord
  has_many :scans
  has_many :products, through: :scans

  # Scan takes in a "product identifier" and a quantity and creates a Scan object, essentially linking this Checkout
  # with a product (and it's quantity). The product identifier can either be the barcode number or name of the product.
  # We leave validation of product_id and quantity to the Scan validation.
  #
  # Note: Quantity can be negative. This will allow the cashier to undo a mistake.
  def scan(product_identifier, quantity = 1)
    product = Product.retrieve_product(product_identifier) # Turn barcode number/name to a Product object
    scan_for_product = scan_for(product)
    update_quantity_or_create_scan(product, quantity.to_i, scan_for_product)
  end

  # Get all the scans for a Checkout.
  def scans
    Scan.where(checkout_id: id)
  end

  # Returns the total cost the shopper owes for this Checkout. It does this by taking all of the scans that were made
  # during this Checkout process & getting their respective costs. The sum of all the scans is the total.
  # If there are no sums, 0 will be returned. Also, it takes in a currency, which will be used if a physical store is
  # located outside of Cabify's country or if a shopper desires to use a different currency.
  def total
    scans.sum { |s| s.total_cost(apply_discount: true) }
  end

  private

  # Increments the quantity of an existing scan or creates a new scan if the product has not been scanned yet. This
  # takes in a product, quantity (which could be negative to allow cashiers the ability to undo), and an existing scan,
  # if one exists. scan_for_product will be nil otherwise.
  def update_quantity_or_create_scan(product, quantity, scan_for_product = nil)
    if scan_for_product
      scan_for_product.quantity += quantity
    else
      scan_for_product = Scan.new(checkout_id: id, product_id: product&.id, quantity: quantity)
    end
    scan_for_product.save! # Takes care of unknown product or a net-negative quantity...
    scan_for_product
  end

  # Finds the scan that occured during this specific Checkout for a given product. It's very possible that this
  # Checkout has yet to scan this product, in which case nil will be returned.
  def scan_for(product)
    scans.select { |s| s.product_id == product&.id }.first
  end
end
