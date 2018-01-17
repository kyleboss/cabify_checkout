FactoryBot.define do
  factory :scan do
    quantity { Faker::Number.digit }
    checkout
    product
  end

  factory :scan_buy_x_get_x_product, parent: :scan do
    product { FactoryBot.build(:buy_x_get_x_product) }
  end

  factory :scan_bulk_product, parent: :scan do
    product { FactoryBot.build(:buld_product) }
  end
end