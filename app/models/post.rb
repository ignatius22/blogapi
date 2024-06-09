class Post < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :content, presence: true


  belongs_to :user
end
