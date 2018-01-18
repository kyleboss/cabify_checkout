FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    base_price { Faker::Commerce.price }
    base_currency 'EUR'
    barcode_number { Faker::Code.imei }
    image_url { Faker::Internet.url }
    type :Product
  end

  factory :buy_x_get_x_product, parent: :product, class: BuyXGetXProduct do
    num_to_buy { Faker::Number.digit }
    num_will_get { Faker::Number.digit }
    type :BuyXGetXProduct
  end

  factory :bulk_product, parent: :product, class: BulkProduct do
    bulk_threshold { Faker::Number.digit }
    bulk_price { Faker::Commerce.price }
    type :BulkProduct
  end
end