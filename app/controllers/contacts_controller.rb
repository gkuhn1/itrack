class ContactsController < AppController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  def index
    @contacts = collection
    respond_with(@contacts)
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  # GET /contacts/0
  def show
    respond_with(@contact)
  end

  # GET /contacts/1/edit
  def edit
    respond_with(@contact)
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    @contact.save
    respond_with(@contact, :location => account_contacts_path(current_account))
  end

  # PATCH/PUT /contacts/1
  def update
    @contact.update_attributes(contact_params)
    respond_with(@contact, :location => account_contacts_path(current_account))
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    respond_with(@contact, :location => account_contacts_path(current_account))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = collection.find(params[:id])
    end

    def collection
      current_account.contacts
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :identifier).merge(account_id: current_account.id)
    end
end
