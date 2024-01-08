# frozen_string_literal: true

require 'watir'
require 'dotenv'
require_relative './iamworkingperson/national_holiday'

Dotenv.load

return if NationalHoliday.new.fetch.include?(Date.today.day) || ENV.fetch('DEBUG', false)

browser = Watir::Browser.new
browser.goto 'https://id.jobcan.jp/users/sign_in?app_key=atd'
browser.text_field(name: 'user[email]').set ENV.fetch('ACCOUNT_NAME')
browser.text_field(name: 'user[password]').set ENV.fetch('ACCOUNT_PASSWORD')
browser.button(name: 'commit').click

browser.goto 'https://ssl.jobcan.jp/employee'
browser.button(name: 'adit_item').click

# debug
#browser.screenshot.save 'screenshot.png'

browser.close
