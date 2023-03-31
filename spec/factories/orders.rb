FactoryBot.define do
  factory :order do
    user { association :user }
    billing { association :billing, user: user }
    shipping_address { association :shipping_address, user: user }
    status { 'open' }
  end
end
