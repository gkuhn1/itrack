require 'rails_helper'

RSpec.describe AppController, type: :controller do

  controller do
    skip_before_filter :set_breadcrumbs
    def index
      render text: "ok"
    end
  end

  before do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:pwd")
  end

  it "should require an account" do
    get :index
    expect(response.code).to eq "403"
  end

  it "should execute action with account" do
    account = create(:account)
    get :index, account_id: account.id
    expect(response.code).to eq "200"
  end

end