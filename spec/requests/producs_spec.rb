require 'rails_helper'

RSpec.describe "Producs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/producs/index"
      expect(response).to have_http_status(:success)
    end
  end
end
