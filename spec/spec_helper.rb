require "simplecov"
SimpleCov.start do
  add_filter '/spec/'
end

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'stormy'

Dir[File.expand_path('spec/support/**/*.rb')].each(&method(:require))

FIXTURE_ROOT = File.join(File.dirname(__FILE__),"fixtures")

