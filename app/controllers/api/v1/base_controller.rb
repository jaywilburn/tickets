require 'json_web_token'
class Api::V1::BaseController < ActionController::API

  include CanCan::ControllerAdditions

  rescue_from StandardError, with: :any_exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::StatementInvalid, with: :bad_request
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from CanCan::AccessDenied, with: :forbidden

  helper_method :current_user

  before_action :authenticate_request

  protected

  def api_error(options={})
    json_hash = Hash.new.tap do |hash|
      hash[:errors] = options[:errors] if options[:errors].present?
      hash[:exception_message] = options[:exception_message] if options[:exception_message].present?
      hash[:exception_backtrace] = options[:exception_backtrace] if options[:exception_backtrace].present?
    end
    render json: json_hash, status: options[:status]
  end

  def current_user
    if decoded_auth_token
      @current_user ||= User.find(decoded_auth_token[:user_id])
    end
  end

  # Check to make sure the current user was set and the token is not expired
  def authenticate_request
    api_error({ errors: "Authentication has expired or it is invalid", status: :unauthorized}) unless decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header_content)
  end

  # JWT's are stored in the Authorization header using this format:
  # Bearer somerandomstring.encoded-payload.anotherrandomstring
  def http_auth_header_content
    # return @http_auth_header_content if defined? @http_auth_header_content
    @http_auth_header_content ||= begin
      request.headers['Authorization'].present? ? request.headers['Authorization'].split(' ').last : nil
    rescue
      nil
    end
  end

  def not_found
    api_error({ errors: "Not Found", status: :not_found })
  end

  def bad_request
    api_error({ errors: "Bad Request", status: :bad_request })
  end

  def forbidden
    api_error({ errors: "Access Denied", status: :forbidden })
  end

  def any_exception(e)
    hash = { errors: "We're sorry, but something went wrong.", status: 500 }
    hash.merge!(exception_message: e.message, exception_backtrace: e.backtrace) unless Rails.env.production?
    api_error(hash)
  end

end
