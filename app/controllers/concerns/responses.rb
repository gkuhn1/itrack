module Responses
  extend ActiveSupport::Concern

  private
    def test_params_json
      raise ::NotAcceptableParameters unless request.env["CONTENT_TYPE"] =~ /application\/json/ or params['format'] == 'json'
    end

    def not_acceptable
      render :json => {:error => 'Not Acceptable'}, :status => 406
    end

    def account_not_found
      render json: { error: "Publisher not found with token %s" % publisher_param }, status: 400
    end

    def unprocessable_entity(message = "Unprocessable Entity")
      render :json => {:error => message}, :status => 422
    end

    def internal_error
      render :json => {:error => "Internal Server Error"}, :status => 500
    end
end
