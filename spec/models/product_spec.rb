require 'rails_helper'

RSpec.describe Product, type: :model do
  it do
    should define_enum_for(:api_url)
      .with_values({
        'https://fakestoreapi.com/products' => 0,
        'https://dummyjson.com/products' => 1
      })
  end

  let(:salmon) { create(:product, title: 'Salmon', price: 50) }
  let(:shirt) { create(:product, title: 'Shirt', price: 52.10) }
  let(:silk) { create(:product, title: 'Silk', price: 10) }
  let(:soldier) { create(:product, title: 'Soldier', price: 5.25) }

  context "#sort_by_name_price" do
    it "sorts by name and price" do
      products = [salmon, shirt, silk, soldier]
      expect(Product.sort_by_title_price).to eq(products)
    end
  end

  context "#filter_by_title_price" do
    it "filters by title and range price" do
      products = [silk, soldier]
      filtered = Product.filter_by_title_price('s', 5, 10)
      expect(filtered).to eq(products)
    end
  end
end
