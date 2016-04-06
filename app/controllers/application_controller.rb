class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_gcm

  def set_gcm
    @gcm ||= GCM.new("AIzaSyC66UfEAHfOcQtVxEHADn1LKudhgMMX04g")
  end
end
