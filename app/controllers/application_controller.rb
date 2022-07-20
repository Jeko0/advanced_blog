class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_query
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_query
    @query = Post.ransack(params[:q])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def logged_in?
    redirect_to new_user_session_path, alert: 'You must be logged in' unless user_signed_in?
  end

  def set_locale 
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
