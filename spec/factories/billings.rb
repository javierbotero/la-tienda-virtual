FactoryBot.define do
  factory :billing do
    user { nil }
    card_number { "5264896547895632" }
    type_card { 1 }
    csv { "985" }
    expiration { "2023-03-18" }
  end
end
