class Role < ApplicationRecord
  validates :name, presence: true

  has_many :accounts
  has_many :users, through: :accounts
end