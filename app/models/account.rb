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
  has_many :drinks

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

  def formatted_drinks
    drinks
      .reverse
  end

  def drinks_today_units
    drinks
      .where("created_at >= '#{Date.today.to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drinks_today_count
    drinks
      .where("created_at >= '#{Date.today.to_s}'")
      .count
  end

  def drinks_week_units
    drinks
      .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drinks_week_count
    drinks
      .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .count
  end

  def drinks_year_units
    drinks
      .where("created_at >= '#{(Date.today.year)}-01-01'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drinks_year_count
    drinks
      .where("created_at >= '#{(Date.today.year)}-01-01'")
      .count
  end

  def drinks_total_units
    drinks
      .sum { |drink| drink.units }
      .round(2)
  end

  def drinks_total_count
    drinks
      .count
  end

  def days_without_drinking
    if drinks.empty?
      return 0
    else
      ((Time.now - drinks.last.created_at) / (24 * 60 * 60)).to_i
    end
  end

  def weekly_breakdown
    total_weeks = (((Date.today.beginning_of_year - Date.today.end_of_week).to_i / 7) * -1)
    array = Array.new(total_weeks, 1)
    array.each { |week| week }
  end
end