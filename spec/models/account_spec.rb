require 'rails_helper'

RSpec.describe Account, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:token) }
  end

  context "#ensure_authentication_token" do
    it "generate new token when create" do
      account = FactoryGirl.build(:account)

      expect(account.token).to be_nil
      account.save
      expect(account.token).not_to eq("")
    end

    it "generate new token when update and token is blank" do
      account = FactoryGirl.create(:account)
      expect(account.token).not_to eq("")

      account.token = ""
      account.save

      expect(account.token).not_to eq("")
    end

    it "not generate new token when update and token isn't blank" do
      account = FactoryGirl.create(:account)
      old_token = account.token
      expect(account.token).not_to eq("")

      account.name = "other text"
      account.save

      expect(account.token).not_to eq("")
      expect(account.token).to eq(old_token)
    end
  end
end
