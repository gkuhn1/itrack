FactoryGirl.define do
  factory :contact do
    name "MyString"
    sequence(:identifier, 'a') { |n| "#{n}" }
    sequence(:email, 'a') { |n| "myemail-#{n}@example.com" }
    account
  end

end
