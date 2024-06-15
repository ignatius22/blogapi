class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[update destroy show]
  before_action :check_owner, only: %i[update destroy]
  before_action :check_login, only: %i[create update destroy]

  def show
    render json: format_post_dates(@post)
  end

  def index
    posts = Post.all.map { |post| format_post_dates(post) }
    render json: posts
  end

  def create
    result = CreatePostService.call(current_user, post_params)
    handle_response(result, :created, :post)
  end

  def update
    result = UpdatePostService.call(@post, post_params)
    handle_response(result, :ok, :post)
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end

  def check_owner
    head :forbidden unless @post.user_id == current_user&.id
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def format_post_dates(post)
    formatted_post = post.as_json(except: [:created_at, :updated_at])
    formatted_post['created_at'] = post.created_at.strftime('%Y-%m-%d %H:%M:%S')
    formatted_post['updated_at'] = post.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    formatted_post
  end
end
