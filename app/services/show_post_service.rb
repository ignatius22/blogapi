class ShowPostService
  def initialize(post_id)
    @post_id = post_id
  end

  def call
    post = Post.find_by(id: @post_id)
    if post
      serialized_post = PostSerializer.new(post).serializable_hash
      { success: true, post: serialized_post }
    else
      { success: false, errors: ['Post not found'] }
    end
  end
end
