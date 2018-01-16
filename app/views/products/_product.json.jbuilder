json.extract! product, :id, :title, :base_price, :base_currency, :barcode_number, :image_url, :num_to_buy,
              :num_will_get, :bulk_threshold, :bulk_price, :created_at, :updated_at
json.url product_url(product, format: :json)
