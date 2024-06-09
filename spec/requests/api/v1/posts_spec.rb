require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Authorization" => JsonWebToken.encode(user_id: user.id) } }

  describe "GET /api/v1/posts/:id" do
    let(:post) { create(:post, user: user) }
    
    before { get "/api/v1/posts/#{post.id}", headers: headers }

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct post information' do
      json_response = JSON.parse(response.body)
      expect(json_response['title']).to eq(post.title)
    end
  end

  describe "GET /api/v1/posts" do
    before { get api_v1_posts_url, headers: headers }

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/v1/posts" do
    it 'creates a post' do
      post_attributes = attributes_for(:post)
      expect {
        post api_v1_posts_url, params: post_attributes.to_json, headers: headers
      }.to change(Post, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "POST /api/v1/posts without authorization" do
    it 'forbids creation of a post without authorization' do
      post_attributes = attributes_for(:post)
      expect {
        post api_v1_posts_url, params: post_attributes.to_json, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PATCH /api/v1/posts/:id" do
    let(:user_one) { create(:user) }
    let(:user_two) { create(:user) }
    let(:post) { create(:post, user: user_one) }
    let(:headers_one) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Authorization" => JsonWebToken.encode(user_id: user_one.id) } }
    let(:headers_two) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Authorization" => JsonWebToken.encode(user_id: user_two.id) } }


    it 'updates post successfully' do
      patch api_v1_post_url(post),
            params: { post: attributes_for(:post) }.to_json,
            headers: headers_one

      expect(response).to have_http_status(:success)
    end

    it 'forbids update of post for unauthorized user' do
      patch api_v1_post_url(post),
            params: { post: attributes_for(:post) }.to_json,
            headers: headers_two

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "DELETE /api/v1/posts/:id" do
    let(:user_one) { create(:user) }
    let(:user_two) { create(:user) }
    let(:post) { create(:post, user: user_one) }
    let(:headers_one) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Authorization" => JsonWebToken.encode(user_id: user_one.id) } }
    let(:headers_two) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Authorization" => JsonWebToken.encode(user_id: user_two.id) } }

    it 'destroys post successfully' do
      expect {
        delete api_v1_post_url(post), headers: headers_one
      }.to change(Post, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'forbids destroy of post for unauthorized user' do
      expect {
        delete api_v1_post_url(post), headers: headers_two
      }.not_to change(Post, :count)

      expect(response).to have_http_status(:forbidden)
    end
  end


end
