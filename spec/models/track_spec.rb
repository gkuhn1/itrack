require 'rails_helper'

RSpec.describe Track, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_presence_of(:contact_id) }
    it { is_expected.to validate_presence_of(:page) }
    it { is_expected.to validate_presence_of(:page_title) }
  end
end

