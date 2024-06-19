# app/services/show_user_service.rb
class ShowUserService < ApplicationService
  def initialize(user_id)
    @user_id = user_id
  end

  def call
    user = User.find_by(id: @user_id)
    options = { include: [:posts] }
    if user
      serialized_user = UserSerializer.new(user, options).serializable_hash
      { success: true, user: serialized_user }
    else
      { success: false, errors: ["User not found"] }
    end
  end
end
