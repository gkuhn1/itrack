class Contact < ActiveRecord::Base
  belongs_to :account

  has_many :tracks
  has_many :messages

  validates :account_id, :identifier, presence: true
  validates :email, uniqueness: {scope: :account_id}, unless: 'email.blank?'
  validates :identifier, uniqueness: {scope: :account_id}
end
