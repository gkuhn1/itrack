class MessagesController < TracksController

  skip_before_action :test_params_json

  before_action :update_contact

  def create
    @message = @contact.messages.create(account_id: current_account.id, body: message_params[:body])
    return redirect_to build_redirect_url if request.referer
    return render text: "Contact sent!"
  end

  private

    def message_params
      params.require(:message).permit(:contact_name, :contact_email, :body, :publisher, :visitor_uid)
    end

    def publisher_param
      message_params[:publisher]
    end

    def visitor_param
      message_params[:visitor_uid]
    end

    def update_contact
      @contact.update_attributes(name: message_params[:contact_name], email: message_params[:contact_email])
    end

    def build_redirect_url
      return "#{request.referer}?contact_sent=ok" unless request.referer.include?("?contact_sent=ok")
      return request.referer
    end

end
