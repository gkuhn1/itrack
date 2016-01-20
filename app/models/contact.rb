class Contact < ActiveRecord::Base
  belongs_to :account

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
