require 'stormy'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

Dir[File.expand_path('spec/support/**/*.rb')].each(&method(:require))

FIXTURE_ROOT = File.join(File.dirname(__FILE__),"fixtures")

