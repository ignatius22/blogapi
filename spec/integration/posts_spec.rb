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

  path '/api/v1/posts/{id}' do
    get 'Retrieves a specific post' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the post'

      response '200', 'post found' do
        schema '$ref' => '#/components/schemas/Post'
        let(:id) { Post.create(title: 'Sample Post', content: 'Sample content').id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
          expect(data['title']).to eq('Sample Post')
          expect(data['content']).to eq('Sample content')
        end
      end

      response '404', 'post not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
  
end
