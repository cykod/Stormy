require "simplecov"
SimpleCov.start

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'stormy'

Dir[File.expand_path('spec/support/**/*.rb')].each(&method(:require))

FIXTURE_ROOT = File.join(File.dirname(__FILE__),"fixtures")

