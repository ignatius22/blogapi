class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :fullname
end
