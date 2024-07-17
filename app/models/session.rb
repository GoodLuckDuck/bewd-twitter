class Session < ApplicationRecord
  before_validation :generate_token

  belongs_to :user

  validates :token, presence: true

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
