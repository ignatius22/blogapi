class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content, :published

  belongs_to :user
end
