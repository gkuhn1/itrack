require 'rails_helper'

RSpec.describe TracksController, type: :controller do

  let(:account) { create(:account) }
  let(:contact) { create(:contact, account_id: account.id)}

  describe "POST #create" do

    let(:valid_attributes) {
      {page: "http://www.google.com/?q=123", page_title: "Search 123", publisher: account.token, visitor_uid: "AAAAAAAAA"}
    }

    let(:invalid_attributes) {
      {page: "http://www.google.com/?q=123", page_title: "Search 123"}
    }

    context "without json content_type" do
      it "should return 406 not_acceptable" do
        post :create, track: valid_attributes.merge(visitor_uid: contact.identifier)
        expect(response.code).to eq "406"
        expect(response.body).to eq "{\"error\":\"Not Acceptable\"}"
      end
    end

    context "with json content_type" do

      before(:each) do
        @request.env["CONTENT_TYPE"] = "application/json"
      end

      context "with invalid publisher" do
        it "should return 400 error" do
          post :create, format: :json, track: invalid_attributes.merge(publisher: "AAAAAA")
          expect(response.code).to eq "400"
          expect(response.body).to eq "{\"error\":\"Publisher not found with token AAAAAA\"}"
        end
      end

      context "with contact" do
        it "should create a new track with associated contact" do
          contact
          expect {
            post :create, format: :json, track: valid_attributes.merge(visitor_uid: contact.identifier)
          }.to change(Track, :count)
        end
        it "should return created track" do
          post :create, format: :json, track: valid_attributes.merge(visitor_uid: contact.identifier)
          expect(response.code).to eq "201"
          expect(JSON.parse(response.body)["page"]).to eq valid_attributes[:page]
          expect(JSON.parse(response.body)["page_title"]).to eq valid_attributes[:page_title]
        end
        context "with track errors" do
          it "should return 422 unprocessable_entity" do
            contact
            post :create, format: :json, track: valid_attributes.merge(visitor_uid: contact.identifier, page: "")
            expect(response.code).to eq "422"
            expect(response.body).to eq "{\"error\":{\"page\":[\"can't be blank\"]}}"
          end
        end
      end

      context "without contact" do







        it "should create a new track and a new contact" do
          expect {
            post :create, format: :json, track: valid_attributes.merge(visitor_uid: "new-identifier-123")
          }.to change(Track, :count).and change(Contact, :count)
        end
        it "should return created track" do
          post :create, format: :json, track: valid_attributes.merge(visitor_uid: "new-identifier-123")
          expect(response.code).to eq "201"
          expect(JSON.parse(response.body)["page"]).to eq valid_attributes[:page]
          expect(JSON.parse(response.body)["page_title"]).to eq valid_attributes[:page_title]
        end
        context "with track errors" do
          it "should create contact and return 422 unprocessable_entity" do
            expect {
              post :create, format: :json, track: valid_attributes.merge(visitor_uid: contact.identifier, page: "")
            }.to change(Contact, :count)
            expect(response.code).to eq "422"
            expect(response.body).to eq "{\"error\":{\"page\":[\"can't be blank\"]}}"
          end
        end
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

end