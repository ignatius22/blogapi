class PostSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :content, :img, :published

  belongs_to :user

  # attribute :created_at do |object|
  #   object.created_at.strftime('%Y-%m-%d %H:%M:%S')
  # end

  # attribute :updated_at do |object|
  #   object.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  # end
end
