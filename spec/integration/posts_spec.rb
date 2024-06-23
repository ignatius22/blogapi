require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/api/v1/posts' do
    get 'Retrieves all posts' do
      tags 'Posts'
      produces 'application/json'
      response '200', 'posts found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Post' }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.size).to eq(Post.count)
        end
      end
    end
  end
end
