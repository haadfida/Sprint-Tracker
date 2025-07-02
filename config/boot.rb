ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# Fix for logger gem conflict with Ruby's built-in Logger in Rails 6.1 - load BEFORE bundler
require 'logger'

require "bundler/setup" # Set up gems listed in the Gemfile.

# require "bootsnap/setup" # Speed up boot time by caching expensive operations.
