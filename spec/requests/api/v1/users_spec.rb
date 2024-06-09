require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/users/:id" do
    let(:user) { create(:user) }

    it "shows user details" do
      get api_v1_user_url(user), params: { format: :json }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['email']).to eq(user.email)
    end
  end

  describe "POST /api/v1/users" do
    context "when creating a user" do
      let(:valid_params) { { user: { email: 'test@test.org', password: '123456', fullname: "John Doe" } } }
      let(:invalid_params) { { user: { email: 'test@test.org', password: '123456', fullname: "John Doe" } } }

      it "creates user" do
        expect {
          post '/api/v1/users', params: valid_params, as: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it "does not create user with taken email" do
        create(:user, email: 'test@test.org') # Create a user with the same email

        expect {
          post '/api/v1/users', params: invalid_params, as: :json
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /api/v1/users/:id" do
    let(:user) { create(:user) }

    context "with valid params" do
      it "updates the user" do
        patch api_v1_user_url(user),
              params: { user: { email: user.email } },
              headers: { 'Authorization' => JsonWebToken.encode(user_id: user.id) },
              as: :json
        expect(response).to have_http_status(:ok)
      end

      it "should forbid update user" do
        patch api_v1_user_url(user),
              params: { user: { email: user.email } },
              as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "with invalid params" do
      it "does not update the user" do
        patch api_v1_user_url(user),
              params: { user: { email: 'bad_email' } },
              headers: { 'Authorization' => JsonWebToken.encode(user_id: user.id) },
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    let!(:user) { create(:user) }

    it "destroys the user" do
      expect {
        delete api_v1_user_url(user), headers: { 'Authorization' => JsonWebToken.encode(user_id: user.id) }, as: :json
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "should forbid destroy user" do
      expect {
        delete api_v1_user_url(user), as: :json
      }.to_not change(User, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
