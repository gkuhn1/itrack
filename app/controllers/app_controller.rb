class NoAccountSelectedException < RuntimeError; end

class AppController < ApplicationController
  include Breadcrumbs
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV["itrack_login"], password: ENV["itrack_pwd"]

  respond_to :html

  rescue_from NoAccountSelectedException, with: :render_forbidden

  before_action :require_account
  before_action :set_breadcrumbs

  private

    def current_account
      @current_account ||= Account.find(params[:account_id])  if params[:account_id]
    end
    helper_method :current_account

    def require_account
      raise NoAccountSelectedException unless current_account
    end

    def render_forbidden
      render text: "Forbidden", :status => 403
    end

end

