# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative './holiday_base'

# NationalHoliday class represents a utility to fetch national holidays in Japan.
class NationalHoliday < HolidayBase
  API_ENDPOINT = 'https://holidays-jp.github.io/api/v1/date.json'
  private_constant :API_ENDPOINT

  private

  def holidays
    res = Net::HTTP.get_response(URI.parse(API_ENDPOINT))
    json = JSON.parse(res.body)
    json.keys
  end
end
