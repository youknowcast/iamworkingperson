# frozen_string_literal: true

require 'date'

# HolidayBase
class HolidayBase
  # @param [Date, nil] date
  def initialize(date: nil)
    @date = if date
              date
            else
              today = Date.today
              Date.new(today.year, today.month, 1)
            end
  end

  def fetch
    ret = []

    holidays.each do |k|
      t = Date.parse(k)
      ret << t.day if t.year == date.year && t.month == date.month
    end

    ret
  end

  private

  attr_reader :date

  def holidays = raise NotImplementedError
end
