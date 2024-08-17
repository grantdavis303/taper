class Drink < ApplicationRecord
  validates :account_id, presence: true, numericality: true
  validates :drink_type, presence: true
  validates :ounces, presence: true, numericality: true
  validates :percentage, presence: true, numericality: true

  belongs_to :account

  def formatted_created_at
    created_at.strftime('%A, %B %-d, %Y')
  end

  def units
    ((percentage.to_f * (ounces.to_f * 29.5735)) / 1000).round(2)
  end
end