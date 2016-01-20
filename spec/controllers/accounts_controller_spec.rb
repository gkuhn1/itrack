require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  let(:valid_attributes) {
    {name: "my account name"}
  }

  let(:invalid_attributes) {
    {name: ""}
  }

  let(:valid_session) { {} }

  before do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("admin:pwd")
  end

  describe "GET #index" do
    it "assigns all accounts as @accounts" do
      account = Account.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:accounts)).to eq([account])
    end
  end

  describe "GET #new" do
    it "assigns a new account as @account" do
      get :new, {}, valid_session
      expect(assigns(:account)).to be_a_new(Account)
    end
  end

  describe "GET #edit" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
      get :edit, {:id => account.to_param}, valid_session
      expect(assigns(:account)).to eq(account)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, {:account => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end

      it "redirects to the created account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(response).to redirect_to(accounts_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(assigns(:account)).to be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "other name"}
      }

      it "updates the requested account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => new_attributes}, valid_session
        account.reload
        expect(account.name).to eq("other name")
      end

      it "assigns the requested account as @account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
      end

      it "redirects to the account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(response).to redirect_to(accounts_url)
      end
    end

    context "with invalid params" do
      it "assigns the account as @account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
      expect {
        delete :destroy, {:id => account.to_param}, valid_session
      }.to change(Account, :count).by(-1)
    end

    it "redirects to the accounts list" do
      account = Account.create! valid_attributes
      delete :destroy, {:id => account.to_param}, valid_session
      expect(response).to redirect_to(accounts_url)
    end
  end

  describe "PUT #update_token" do
    it "update token" do
      account = Account.create! valid_attributes

      old_token = account.token

      xhr :put, :update_token, {id: account.id}, valid_session

      expect(assigns(:account).token).not_to eq(old_token)
    end

    it "respond to update_token" do
      account = Account.create! valid_attributes
      xhr :put, :update_token, {id: account.id}, valid_session

      expect(response).to render_template("update_token")
    end
  end

end
