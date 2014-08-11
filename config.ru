require './app'


use Rack::Static, :urls => ["/assets"], :root => "public"


run StormyApp.new

