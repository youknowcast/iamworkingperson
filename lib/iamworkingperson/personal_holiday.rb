# frozen_string_literal: true

require 'net/http'
require 'json'
require 'dotenv'
require_relative './holiday_base'

##
# The PersonalHoliday class represents a holiday that is specific to a person.
class PersonalHoliday < HolidayBase
  API_ENDPOINT = ENV.fetch('PERSONAL_HOLIDAY_API', nil)
  private_constant :API_ENDPOINT

  private

  def holidays
    return [] if API_ENDPOINT.nil?

    res = Net::HTTP.get_response(URI.parse(API_ENDPOINT))
    json = JSON.parse(res.body)
    json['holiday']
  end
end
