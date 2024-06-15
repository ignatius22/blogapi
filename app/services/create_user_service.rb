# app/services/create_user_service.rb
class CreateUserService < ApplicationService
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user = User.new(@user_params)
    if user.save
      serialized_user = UserSerializer.new(user).serializable_hash
      { success: true, user: serialized_user }
    else
      { success: false, errors: user.errors.full_messages }
    end
  end
end
