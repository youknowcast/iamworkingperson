# frozen_string_literal: true

require 'watir'
require 'dotenv'
require_relative './national_holiday'

##
# Calls the `call!` method on a new instance of BrowserController.
#
# @return [void]
class BrowserController
  def self.call!
    new.call!
  end

  def call!
    return unless callable?

    session do
      debug_mode? ? check_login! : punch!
    end
  end

  private

  attr_reader :browser

  def debug_mode?
    ENV.fetch('DEBUG', false)
  end

  def callable?
    debug_mode? || not_holiday?
  end

  def not_holiday?
    day_in_jp = (Time.now.utc + (9 * 60 * 60)).day
    !NationalHoliday.new.fetch.include?(day_in_jp)
  end

  def session
    @browser = Watir::Browser.new(:chrome, url: 'http://127.0.0.1:4444/wd/hub')

    login
    yield
    browser.close
  end

  def login
    browser.goto 'https://id.jobcan.jp/users/sign_in?app_key=atd'
    browser.text_field(name: 'user[email]').set ENV.fetch('ACCOUNT_NAME')
    browser.text_field(name: 'user[password]').set ENV.fetch('ACCOUNT_PASSWORD')
    browser.button(name: 'commit').click
  end

  def punch!
    browser.goto 'https://ssl.jobcan.jp/employee'
    browser.button(name: 'adit_item').click
  end

  def check_login!
    browser.screenshot.save 'screenshot.png'
  end
end
