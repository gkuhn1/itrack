class AccountsController < AppController
  before_action :set_account, only: [:edit, :update, :destroy, :update_token]
  skip_before_action :require_account

  respond_to :js, only: [:update_token]

  # GET /accounts
  def index
    @accounts = Account.all
    respond_with(@accounts)
  end

  # GET /accounts/new
  def new
    @account = Account.new
    respond_with(@account)
  end

  # GET /accounts/1/edit
  def edit
    respond_with(@account)
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.save
    respond_with(@account, :location => accounts_path)
  end

  # PATCH/PUT /accounts/1
  def update
    @account.update_attributes(account_params)
    respond_with(@account, :location => accounts_path)
  end

  # PATCH/PUT /accounts/1/update_token
  def update_token
    @account.token = nil
    @account.save

    respond_with(@account)
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    respond_with(@account, :location => accounts_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:name, :token)
    end
end
