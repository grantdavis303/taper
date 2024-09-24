class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true # add test for uniqueness?
  validate :valid_email

  has_one :account
  has_one :role, through: :account

  def valid_email
    if email.nil? || email.empty?
      errors.add(:email, 'is not valid')
    else
      errors.add(:email, 'is missing a @') if !email.include?('@')
      errors.add(:email, 'is missing a domain') if !email.include?('.')
    end
  end
end