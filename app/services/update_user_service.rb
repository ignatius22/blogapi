# app/services/update_user_service.rb
class UpdateUserService < ApplicationService
  def initialize(user_id, user_params)
    @user_id = user_id
    @user_params = user_params
  end

  def call
    user = User.find_by(id: @user_id)
    if user
      if user.update(@user_params)
        { success: true, user: user }
      else
        { success: false, errors: user.errors.full_messages }
      end
    else
      { success: false, errors: ["User not found"] }
    end
  end
end
