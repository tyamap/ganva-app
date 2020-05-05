class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
  before_action :basic_auth
  protect_from_forgery with: :exception

  include ErrorHandlers if Rails.env.production?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth[:username] &&
        password == Rails.application.credentials.basic_auth[:password]
    end
  end
end
