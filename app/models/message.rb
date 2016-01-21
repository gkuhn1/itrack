class Message < ActiveRecord::Base
  belongs_to :contact
  belongs_to :account

  validates :account_id, :contact_id, presence: true
end
