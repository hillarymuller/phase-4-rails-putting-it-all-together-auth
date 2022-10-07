class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorized!
rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid

private
def render_not_valid(invalid)
  render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
end
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
def no_route
  render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
end
def authorized!
  no_route unless current_user
end
end
