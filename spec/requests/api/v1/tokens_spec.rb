require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do


  # describe "GET /create" do
  #   it "returns http success" do
  #     post "/api/v1/tokens/create"
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  describe "POST /api/v1/tokens" do
    let(:user) { create(:user) }

    it "returns a JWT token when valid credentials are provided" do
      post api_v1_tokens_url, params: { user: { email: user.email, password: 'g00d_pa$$' } }, as: :json
      
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['token']).not_to be_nil
    end

    it "does not return a JWT token when invalid credentials are provided" do
      post api_v1_tokens_url, params: { user: { email: user.email, password: 'b@d_pa$$' } }, as: :json
      
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
