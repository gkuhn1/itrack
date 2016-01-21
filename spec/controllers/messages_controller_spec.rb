require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let(:account) { create(:account) }
  let(:contact) { create(:contact, account_id: account.id)}

  describe "POST #create" do

    let(:valid_attributes) {
      {body: "My message", contact_name: "MyName", contact_email: "newemail@example.com", publisher: account.token, visitor_uid: "AAAAAAAAA"}
    }

    let(:invalid_attributes) {
      {body: "", contact_name: "MyName", contact_email: "newemail@example.com"}
    }


    context "with invalid publisher" do
      it "should return 400 error" do
        post :create, format: :json, message: invalid_attributes.merge(publisher: "AAAAAA")
        expect(response.code).to eq "400"
        expect(response.body).to eq "{\"error\":\"Publisher not found with token AAAAAA\"}"
      end
    end

    it "should create a new message with associated contact and account" do
      contact
      expect {
        post :create, format: :json, message: valid_attributes.merge(visitor_uid: contact.identifier)
      }.to change(Message, :count)
    end
    it "should redirect to referer if exists" do
      request.env['HTTP_REFERER'] = 'http://example.com/contact.html'
      post :create, format: :json, message: valid_attributes.merge(visitor_uid: contact.identifier)
      expect(response.code).to eq "302"
      expect(response).to redirect_to "http://example.com/contact.html?contact_sent=ok"
    end
    it "should redirect correct if referer already have contact_sent" do
      request.env['HTTP_REFERER'] = "http://example.com/contact.html?contact_sent=ok"
      post :create, format: :json, message: valid_attributes.merge(visitor_uid: contact.identifier)
      expect(response.code).to eq "302"
      expect(response).to redirect_to "http://example.com/contact.html?contact_sent=ok"
    end
    it "should respond 200 if referer does nt exists" do
      post :create, format: :json, message: valid_attributes.merge(visitor_uid: contact.identifier)
      expect(response.code).to eq "200"
      expect(response.body).to eq "Contact sent!"
    end

    context "internal server error" do

      it "should return 500 with message Internal Server Error" do
        allow(subject).to receive(:create) do
          raise ArgumentError
        end
        post :create
        expect(response.code).to eq "500"
        expect(response.body).to eq "{\"error\":\"Internal Server Error\"}"
      end
    end

  end

end
