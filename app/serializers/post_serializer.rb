class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content, :published, :img

  belongs_to :user
end
