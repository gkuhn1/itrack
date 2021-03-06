require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_uniqueness_of(:identifier).scoped_to(:account_id) }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:account_id) }
  end
end
