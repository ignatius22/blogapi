class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content, :published
end
