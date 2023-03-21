FactoryBot.define do
  factory :shipping_address do
    user { nil }
    address { "MyString" }
    country { "MyString" }
    state { "MyString" }
    city { "MyString" }
    zipcode { "MyString" }
  end
end
