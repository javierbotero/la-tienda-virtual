FactoryBot.define do
  factory :product do
    api_url { 0 }
    sequence :external_id do |n|
      "#{n}"
    end
    title { "MyString" }
    stock { 1 }
    price { 9.99 }
    images { 'mysite.com/image1.jpg' }
  end
end
