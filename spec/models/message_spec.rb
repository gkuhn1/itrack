require 'rails_helper'

RSpec.describe Message, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_presence_of(:contact_id) }
  end
end
