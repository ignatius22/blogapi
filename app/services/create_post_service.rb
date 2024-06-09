# app/services/create_post_service.rb
class CreatePostService < ApplicationService
  def initialize(user, post_params)
    super()
    @user = user
    @post_params = post_params
  end

  def call
    post = @user.posts.build(@post_params)
    if post.save
      success!(post: post)
    else
      failure!(post.errors.full_messages)
    end
  end
end