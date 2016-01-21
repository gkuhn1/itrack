FactoryGirl.define do
  factory :track do
    page "https://www.google.com/?q=123"
    page_title "Search 123"
    account
    contact
  end

end
