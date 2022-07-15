class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :set_locale
  before_action :set_query

  def set_query
    @query = Post.ransack(params[:q])
  end

  private

  def logged_in?
    redirect_to new_user_session_path, alert: 'You must be logged in' if current_user.nil?
  end

  def set_locale 
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
