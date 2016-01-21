FactoryGirl.define do
  factory :message do
    contact
    body "MyText"
    account
  end

end
