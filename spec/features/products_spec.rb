require 'rails_helper'

RSpec.feature "Products", type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:salmon) { create(:product, title: 'Salmon', price: 50, stock: 2) }
  let!(:shirt) { create(:product, title: 'Shirt', price: 52.10) }
  let!(:silk) { create(:product, title: 'Silk', price: 10) }
  let!(:soldier) { create(:product, title: 'Soldier', price: 5.25) }

  before do
    visit login_path

    within 'form' do
      fill_in 'Username', with: user.username
      fill_in 'Email', with: user.email
      click_on 'Log in'
    end
  end

  context 'when user see list of products' do
    it 'list products sorted and filtered by name and price range' do
      expect(page).to have_selector('.products', text: /Salmon.+Shirt.+Silk.+Soldier/i, visible: false)

      within '.filter-products' do
        fill_in 'By name', with: 'sal'
        fill_in 'min', with: '40'
        fill_in 'max', with: '60'
        click_on 'filter'
      end

      expect(page).to have_selector('ul.products li', count: 1)

      within '.filter-products' do
        fill_in 'By name', with: 'sal'
        fill_in 'min', with: '60'
        fill_in 'max', with: '70'
        click_on 'filter'
      end

      expect(page).to have_selector('ul.products li', count: 0)

      within '.filter-products' do
        fill_in 'By name', with: 's'
        fill_in 'min', with: '10'
        fill_in 'max', with: '50'
        click_on 'filter'
      end

      expect(page).to have_selector('ul.products li', count: 2)
    end

    it 'click in first product and in the view of the product increment quantity', skip: true do
      within('ul.products') do
        first('li a').click
      end

      expect(page).to have_text('Salmon')

      stock = find('.stock').text.to_i
      i = 0

      while i < stock
        initial_quantity = find('.quantity').text.to_i
        initial_total = find('.total').text.to_d
        price_product = find('.price').text.to_d

        expect(initial_total).to eq(price_product * i)

        i += 1
        find(".increment").click
        new_quantity = find('.quantity').value.to_i
        new_total = find('.total').text.to_i

        expect(new_quantity).to eq(i)
        expect(new_total).to eq(price_product * i)
      end

      find(".increment").click
      message = find(".stock-error")

      expect(message.text).to eq("Not available quantity")

      find(".decrement").click
      message = find(".stock-error")

      expect(message.text).to eq("")
    end
  end

  it "Create an order" do
    within('ul.products') do
      first('li a').click
    end

    sleep 0.3

    find(".increment").click
    find(".increment").click
    click_on 'Add to Cart'

    sleep 0.3

    expect(page).to have_selector('li', text: 'Cart')
    click_on 'Cart'

    expect(page).to have_selector('ul', text: /#{salmon.name}.+2.+#{salmon.price * 2}/i)
  end
end
