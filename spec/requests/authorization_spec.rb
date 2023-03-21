require 'rails_helper'

RSpec.describe "Authorizations", type: :request do
  describe "GET /login" do
    it "returns http success" do
      get "/authorization/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /logout" do
    it "returns http success" do
      get "/authorization/logout"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /register" do
    it "returns http success" do
      get "/authorization/register"
      expect(response).to have_http_status(:success)
    end
  end

end
