class Api::V1::TokensController < ApplicationController

  def create
    result = CreateTokenService.call(user_params[:email], user_params[:password])
    handle_response(result, :ok)
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
