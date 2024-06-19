# app/services/show_post_service.rb
class ShowPostService
  def initialize(post_id)
    @post_id = post_id
  end

  def call
    post = Post.find_by(id: @post_id)
    options = { include: [:user] }  # Assuming `:user` is the association name in Post model
    if post
      serialized_post = PostSerializer.new(post, options).serializable_hash
      { success: true, post: serialized_post }
    else
      { success: false, errors: ['Post not found'] }
    end
  end
end
