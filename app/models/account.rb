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
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day) # ("drinks.created_at = '#{Time.current.beginning_of_day.to_date.to_s}'")
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
      .where(created_at: Time.current.beginning_of_week..Time.current.end_of_week) # ("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_week
    drinks
      .where(created_at: Time.current.beginning_of_week..Time.current.end_of_week) # .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .count
  end

  def drink_units_this_month
    drinks
      .where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) # ("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_month
    drinks
      .where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) # .where("created_at > '#{(Date.today.at_beginning_of_week).to_s}'")
      .count
  end

  def drink_units_this_year
    drinks
      .where(created_at: Time.current.beginning_of_year..Time.current.end_of_year) # v.where("created_at >= '#{(Date.today.year)}-01-01'")
      .sum { |drink| drink.units }
      .round(2)
  end

  def drink_count_this_year
    drinks
      .where(created_at: Time.current.beginning_of_year..Time.current.end_of_year) # .where("created_at >= '#{(Date.today.year)}-01-01'")
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

  def weeks_this_year
    Date.today.cweek
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
      user_drinks = drink_count_specific(week_start, week_end)

      week = {
        count: week_number,
        start: week_start,
        end: week_end,
        units: units,
        drinks: user_drinks
      }

      if drinks.count == 0
        if Time.current.beginning_of_week.to_date == week[:start]
          week[:background_color] = '009900'
          week[:font_color] = 'FFFFFF'
          week[:week_status] = 'Perfect'
        else
          week[:background_color] = 'CCCCCC'
          week[:font_color] = '000000'
          week[:week_status] = 'Untracked'
        end
      else
        if week[:start] < drinks.first.created_at.beginning_of_week.to_date
          week[:background_color] = 'CCCCCC'
          week[:font_color] = '000000'
          week[:week_status] = 'Untracked'
        elsif drink_units_specific(week[:start], week[:end]) == 0
          week[:background_color] = '009900'
          week[:font_color] = 'FFFFFF'
          week[:week_status] = 'Perfect'
        elsif drink_units_specific(week[:start], week[:end]) <= 7
          week[:background_color] = '00CC00'
          week[:font_color] = 'FFFFFF'
          week[:week_status] = 'Really Good'
        elsif drink_units_specific(week[:start], week[:end]) <= 14
          week[:background_color] = 'E5FFCC'
          week[:font_color] = '000000'
          week[:week_status] = 'Good'
        elsif drink_units_specific(week[:start], week[:end]) <= 21
          week[:background_color] = 'CC0000'
          week[:font_color] = 'FFFFFF'
          week[:week_status] = 'Over'
        elsif drink_units_specific(week[:start], week[:end]) > 21
          week[:background_color] = '990000'
          week[:font_color] = 'FFFFFF'
          week[:week_status] = 'Really Over'
        end
      end

      week_number += 1
      current_day += 7
      array << week
    end

    array.reverse
  end

  def weeks_status_count(status_type)
    weekly_breakdown = generate_weekly_breakdown

    if drinks.count == 0
      return 0
    elsif status_type == 'Perfect'
      weekly_breakdown.map { |week| week[:units] if (week[:units] == 0 && week[:start] > drinks.first.created_at.beginning_of_week.to_date) }
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
    elsif status_type == 'Really Over'
      weekly_breakdown.map { |week| week[:units] if week[:units] > 21 }
        .compact
        .count
    elsif status_type == 'Untracked'
      weekly_breakdown.map { |week| week[:units] if week[:start] < drinks.first.created_at.beginning_of_week.to_date }
        .compact
        .count
    end
  end
end