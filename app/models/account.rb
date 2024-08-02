class Account < ApplicationRecord
  validates :user_id, presence: true, numericality: true
  validates :role_id, presence: true, numericality: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8, maximum: 64 }
  validates :last_login, presence: true
  validate :valid_password
  has_secure_password

  belongs_to :user
  belongs_to :role

  def valid_password
    if password.nil? || password.empty?
      errors.add(:password, 'is missing all required characters') 
    else
      errors.add(:password, 'is missing a special character') if password[/[!@#$%^&* ]/] == nil
      errors.add(:password, 'is missing a number') if password[/[0123456789]/] == nil
      errors.add(:password, 'is missing a lowercase character') if password[/[a-z]/] == nil
      errors.add(:password, 'is missing a uppercase character') if password[/[A-Z]/] == nil
    end
  end 
end