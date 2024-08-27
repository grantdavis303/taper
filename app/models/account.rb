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

  def all_drinks_in_reverse_order
    drinks
      .reverse
  end

  def drink_units_today
    drinks
      .where("created_at >= '#{Date.today.to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_today
    drinks
      .where("created_at >= '#{Date.today.to_s}'")
      .count
  end

  def drink_units_this_week
    drinks
      .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_week
    drinks
      .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .count
  end

  def drink_units_this_year
    drinks
      .where("created_at >= '#{(Date.today.year)}-01-01'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_year
    drinks
      .where("created_at >= '#{(Date.today.year)}-01-01'")
      .count
  end

  def drink_units_all_time
    drinks
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_all_time
    drinks
      .count
  end

  def drink_units_specific(start_date, end_date)
    drinks
      .where("created_at >= '#{start_date}' AND created_at < '#{end_date + 1}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_specific(start_date, end_date)
    drinks
      .where("created_at >= '#{start_date}' AND created_at < '#{end_date + 1}'") # <= make sense?
      .count
  end

  def weeks_this_year # Date.today.cweek
    (((Date.today.beginning_of_year - Date.today.end_of_week).to_i / 7) * -1)
  end

  def weeks_status_count(status_type)
    weekly_breakdown = generate_weekly_breakdown

    if status_type == 'Perfect'
      weekly_breakdown.map { |week| week[:units] if week[:units] == 0 }
        .compact
        .count
    elsif status_type == 'Really Good'
      weekly_breakdown.map { |week| week[:units] if week[:units] > 0 && week[:units] <= 7 }
        .compact
        .count
    elsif status_type == 'Good'
      weekly_breakdown.map { |week| week[:units] if week[:units] > 7 && week[:units] <= 14 }
        .compact
        .count
    elsif status_type == 'Over'
      weekly_breakdown.map { |week| week[:units] if week[:units] > 14 && week[:units] <= 21 }
        .compact
        .count
    else
      weekly_breakdown.map { |week| week[:units] if week[:units] > 21 }
        .compact
        .count
    end
  end

  def generate_weekly_breakdown
    total_weeks = weeks_this_year
    current_day = 0
    week_number = 1
    array = Array.new

    total_weeks.times do
      week_start = Date.today.beginning_of_year + current_day
      week_end = Date.today.beginning_of_year + current_day + 6
      units = drink_units_specific(week_start, week_end)
      drinks = drink_count_specific(week_start, week_end)

      week = {
        count: week_number,
        start: week_start,
        end: week_end,
        units: units,
        drinks: drinks
      }

      week_number += 1
      current_day += 7

      array << week
    end

    array.reverse
  end
end