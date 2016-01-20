class Account < ActiveRecord::Base
  validates :name, :token, presence: true
  validates :token, uniqueness: true

  before_validation :ensure_authentication_token

  private
    def ensure_authentication_token
      if token.blank?
        self.token = generate_authentication_token
      end
    end

    def generate_authentication_token
      loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Account.exists?(token: random_token)
      end
    end
end
