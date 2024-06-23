class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :fullname

  has_many :posts

  # attribute :created_at do |object|
  #   object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  # end

  # attribute :updated_at do |object|
  #   object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  # end

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
