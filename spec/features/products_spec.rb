require 'rails_helper'

RSpec.feature "Products", type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:salmon) { create(:product, title: 'Salmon', price: 50) }
  let!(:shirt) { create(:product, title: 'Shirt', price: 52.10) }
  let!(:silk) { create(:product, title: 'Silk', price: 10) }
  let!(:soldier) { create(:product, title: 'Soldier', price: 5.25) }

  before do
    visit login_path

    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    click_on 'Log in'
  end

  context 'when user see list of products' do
    it 'list products sorted and filters then by name and price range' do
      visit products_path
      
      expect(page).to have_text /Salmon.+Shirt.+Silk.+Soldier/i
    end
  end
end
