# frozen_string_literal: true

require 'net/http'
require 'json'
require 'date'

class NationalHoliday
  API_ENDPOINT = 'https://holidays-jp.github.io/api/v1/date.json'
  private_constant :API_ENDPOINT

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

    holidays.each do |k, _|
      t = Date.parse(k)
      ret << t.day if t.year == date.year && t.month == date.month
    end

    ret
  end

  private

  attr_reader :date

  def holidays
    res = Net::HTTP.get_response(URI.parse(API_ENDPOINT))
    JSON.parse(res.body)
  end
end
