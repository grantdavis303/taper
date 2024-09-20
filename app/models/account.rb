class Account < ApplicationRecord
  validates :user_id, presence: true, numericality: true
  validates :role_id, presence: true, numericality: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8, maximum: 64 }
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

  # Basic Queries

  def all_drinks_in_reverse_order
    drinks
      .order(:created_at)
      .reverse
  end

  def weeks_this_year
    Time
      .current
      .to_datetime
      .cweek
  end

  # Drink Units and Counts

  def drink_units_today
    drinks
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_today
    drinks
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
      .count
  end

  def drink_units_this_week
    drinks
      .where(created_at: Time.current.beginning_of_week..Time.current.end_of_week)
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_week
    drinks
      .where(created_at: Time.current.beginning_of_week..Time.current.end_of_week)
      .count
  end

  def drink_units_this_month
    drinks
      .where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_month
    drinks
      .where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
      .count
  end

  def drink_units_this_year
    drinks
      .where(created_at: Time.current.beginning_of_year..Time.current.end_of_year)
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_year
    drinks
      .where(created_at: Time.current.beginning_of_year..Time.current.end_of_year)
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
      .where("created_at >= '#{start_date}' AND created_at < '#{end_date + 1}'") # <= does this even make sense?
      .count
  end

  # Weekly Breakdowns

  def generate_single_week_breakdown
    week = {
      start: Time.current.beginning_of_week.to_date,
      end: Time.current.end_of_week.to_date,
      units: drink_units_this_week,
      drinks: drink_count_this_week
    }

    determine_week_design(week)
    week
  end

  def generate_weekly_breakdown
    list_of_weeks = Array.new
    total_weeks = weeks_this_year
    current_day = 0
    week_number = 1

    total_weeks.times do
      start_date = Time.current.beginning_of_year.to_date + current_day
      end_date = Time.current.beginning_of_year.to_date + current_day + 6
      week = {
        count: week_number,
        start: start_date,
        end: end_date,
        units: drink_units_specific(start_date, end_date),
        drinks: drink_count_specific(start_date, end_date)
      }

      if week[:start] >= created_at.beginning_of_week.to_date
        determine_week_design(week)
      else
        week[:background_color] = 'CCCCCC'
        week[:font_color] = '000000'
        week[:week_status] = 'Untracked'
      end

      current_day += 7
      week_number += 1
      list_of_weeks << week
    end

    list_of_weeks.reverse
  end

  def determine_week_design(week)
    if week[:units] == 0
      week[:background_color] = '009900'
      week[:font_color] = 'FFFFFF'
      week[:week_status] = 'Perfect'
    elsif week[:units] <= 7
      week[:background_color] = '00CC00'
      week[:font_color] = 'FFFFFF'
      week[:week_status] = 'Really Good'
    elsif week[:units] <= 14
      week[:background_color] = 'E5FFCC'
      week[:font_color] = '000000'
      week[:week_status] = 'Good'
    elsif week[:units] <= 21
      week[:background_color] = 'CC0000'
      week[:font_color] = 'FFFFFF'
      week[:week_status] = 'Over'
    elsif week[:units] > 21
      week[:background_color] = '990000'
      week[:font_color] = 'FFFFFF'
      week[:week_status] = 'Really Over'
    end
  end

  # Weekly Status Counts

  def weeks_status_count(status_type)
    generate_weekly_breakdown
      .map { |week| week[:week_status] if week[:week_status] == status_type }
      .compact
      .count
  end
end