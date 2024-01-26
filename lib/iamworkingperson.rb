# frozen_string_literal: true

require 'dotenv'
require 'webdrivers'
require_relative './iamworkingperson/browser_controller'

Dotenv.load

BrowserController.call!
