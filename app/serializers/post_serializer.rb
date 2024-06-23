class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content, :published, :img

  belongs_to :user
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
