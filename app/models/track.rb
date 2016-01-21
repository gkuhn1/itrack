class Track < ActiveRecord::Base
  belongs_to :account
  belongs_to :contact

  validates :page, :page_title, :account_id, :contact_id, presence: true
end
