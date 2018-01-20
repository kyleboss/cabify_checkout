FactoryBot.define do
  factory :checkout_state do
    update_obj { FactoryBot.build_stubbed(:checkout) }
    initialize_with { new(update_obj) }
  end
end