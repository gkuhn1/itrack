class NotAcceptableParameters < RuntimeError; end

class TracksController < ApplicationController
  include Responses

  skip_before_action :verify_authenticity_token

  respond_to :json

  rescue_from StandardError, with: :internal_error
  rescue_from ::NoAccountSelectedException, with: :account_not_found
  rescue_from ::NotAcceptableParameters, with: :not_acceptable

  before_action :test_params_json
  before_action :require_account
  before_action :find_or_create_contact

  def create
    @track = current_account.tracks.create(page: track_params[:page], page_title: track_params[:page_title], contact: @contact)
    return unprocessable_entity(@track.errors) if @track.errors.any?
    render status: 201
  end

  private

    def track_params
      params.require("track").permit(:publisher, :visitor_uid, :page, :page_title)
    end

    def publisher_param
      track_params[:publisher]
    end

    def visitor_param
      track_params[:visitor_uid]
    end

    def current_account
      @current_account ||= Account.find_by(token: publisher_param)  if publisher_param
    end
    helper_method :current_account

    def require_account
      raise ::NoAccountSelectedException unless current_account
    end

    def find_or_create_contact
      @contact = current_account.contacts.find_or_create_by(identifier: visitor_param)
    end

end