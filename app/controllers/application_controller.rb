class ApplicationController < ActionController::API
  include Authenticable
  include ResponseHandler
end
