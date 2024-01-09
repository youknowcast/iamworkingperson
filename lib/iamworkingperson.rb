# frozen_string_literal: true

require 'watir'
require 'dotenv'
require_relative './iamworkingperson/national_holiday'

Dotenv.load

unless ENV.fetch('DEBUG', false)
  day_in_jp = (Time.now.utc + (9 * 60 * 60)).day
  return if NationalHoliday.new.fetch.include?(day_in_jp)
end

browser = Watir::Browser.new(:chrome, headless: true)
browser.goto 'https://id.jobcan.jp/users/sign_in?app_key=atd'
browser.text_field(name: 'user[email]').set ENV.fetch('ACCOUNT_NAME')
browser.text_field(name: 'user[password]').set ENV.fetch('ACCOUNT_PASSWORD')
browser.button(name: 'commit').click

browser.goto 'https://ssl.jobcan.jp/employee'
#browser.button(name: 'adit_item').click

# debug
browser.screenshot.save 'screenshot.png'

browser.close

