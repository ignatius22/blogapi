class Post < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :content, presence: true


  belongs_to :user

  scope :filter_by_title, lambda { |keyword| where('lower(title) iLIKE ?', "%#{keyword.downcase}%") }
  scope :recent, -> { order(updated_at: :desc) }

  def self.search(params = {})
    posts = params[:post_ids].present? ? where(id: params[:post_ids]) : all
    posts = posts.filter_by_title(params[:keyword]) if params[:keyword].present?
    posts = posts.recent if params[:recent].present?

    posts
  end
end
