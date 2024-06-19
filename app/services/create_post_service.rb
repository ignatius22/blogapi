# app/services/create_post_service.rb
class CreatePostService < ApplicationService
  def initialize(user, post_params)
    @user = user
    @post_params = post_params
  end

  def call

    post = @user.posts.build(@post_params)
    
    if post.save
      serialized_post = PostSerializer.new(post).serializable_hash
      { success: true, post: serialized_post }
    else
      { success: false, errors: post.errors.full_messages }
    end
  end
end
