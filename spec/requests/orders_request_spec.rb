require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user) }
  let(:bed) { create(:product, title: 'bed', price: '125.50') }
  let(:couch) { create(:product, title: 'couch', price: '135.50') }

  before do
    post login_user_url,
         params: {
           user: { username: user.username, email: user.email }
         }
    follow_redirect!
  end

  describe 'POST #create via json' do
    let(:params) do
      {
        order: {
          line_items_attributes: [
            {
              product_id: bed.id,
              quantity: 2
            }
          ]
        }
      }
    end

    it 'creates an order' do
      expect do
        post user_orders_url(user) + '.json',
             params: params.to_json,
             headers: { 'Content-Type' => 'application/json' }
      end.to change(Order, :count).by(1)
    end
    it 'creates an order and returns proper json response' do
      post user_orders_url(user) + '.json', params: params.to_json, headers: { 'Content-Type' => 'Application/json' }
      order = Order.last

      expect(response.body).to eq({
        success: true,
        order_id: order.id
      }.to_json)
    end
    it 'sets the order in the cookies' do
      post user_orders_url(user) + '.json', params: params.to_json, headers: { 'Content-Type' => 'Application/json' }
      order = Order.last

      expect(session[:order_id]).to eq order.id
    end
  end

  describe 'PATCH #update via json' do
    let(:order) { create(:order, user: user) }
    let(:line_item1) { create(:line_item, order: order, product: bed) }
    let(:line_item2) { create(:line_item, order: order, product: couch) }
    let(:billing) { create(:billing, user: user) }
    let(:shipping_address) { create(:shipping_address, user: user) }
    let(:params) do
      {
        order: {
          status: 1,
          line_items_attributes: {
            line_item1.id => {
              product_id: line_item1.product_id,
              quantity: line_item1.quantity
            },
            line_item2.id => {
              product_id: line_item2.product_id,
              quantity: line_item2.quantity
            }
          }
        }
      }
    end

    context 'updates the order to pending' do
      it 'fails to update without a billing and address' do
        patch user_order_url(user, order) + '.json',
              params: params.to_json,
              headers: { 'Content-Type' => 'application/json' }

        expect(response.status).to eq 422
      end

      it 'Updates to pending' do
        order.update!(billing: billing, shipping_address: shipping_address)

        patch user_order_url(user, order) + '.json',
              params: params.to_json,
              headers: { 'Content-Type' => 'application/json' }

        expect(response.status).to eq 200
      end
    end
  end
end
