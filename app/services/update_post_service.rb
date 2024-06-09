# app/services/update_post_service.rb
class UpdatePostService < ApplicationService
  def initialize(post, post_params)
    super()
    @post = post
    @post_params = post_params
  end

  def call
    if @post.update(@post_params)
      success!(post: @post)
    else
      failure!(@post.errors.full_messages)
    end
  end
end
