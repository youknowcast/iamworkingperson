# frozen_string_literal: true

require 'dotenv'
require_relative './iamworkingperson/browser_controller'

Dotenv.load

BrowserController.call!
