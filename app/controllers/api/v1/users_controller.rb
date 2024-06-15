class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]

  def show
    result = ShowUserService.call(params[:id])
    handle_response(result, :ok, :user)
  end

  def create
    result = CreateUserService.call(user_params)
    handle_response(result, :created, :user)
  end

  def update
    result = UpdateUserService.call(params[:id], user_params)
    handle_response(result, :ok, :user)
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  def user_params
    params.require(:user).permit(:email, :password, :fullname)
  end
end
