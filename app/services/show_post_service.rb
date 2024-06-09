# app/services/show_post_service.rb
class ShowPostService
  def initialize(post_id)
    @post_id = post_id
  end

  def call
    post = Post.find_by(id: @post_id)
    if post
      { success: true, post: post }
    else
      { success: false, errors: ['Post not found'] }
    end
  end
end
