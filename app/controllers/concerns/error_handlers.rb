module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from ActionController::ParameterMissing, with: :rexcue400
  end

  private

  def rescue400(_exception)
    render 'errors/bad_request', statfus: 400
  end

  def rescue403(exception)
    @exception = exception
    render 'errors/forbidden', status: :forbidden
  end

  def rescue404(_exception)
    render 'errors/not_found', status: :not_found
  end

  def rescue500(_exception)
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
