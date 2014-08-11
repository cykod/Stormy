require "rack"
require "rack/mime"
require_relative "lib/stormy"

Stormy.root =  File.dirname(__FILE__) 

class StormyApp
  def call(env)
    output = render(::Rack::Utils.unescape(env['PATH_INFO']))
    [200, {"Content-Type" => "text/html"}, [ output ] ] 
  end

  def render(path)
    # find a page that matches
    @page = Stormy::Page.new(path,{})

    if @page.valid?
      @page.render
    else
      @error_page = Stormy::Page.new("/404", {})
      @error_page.render
    end
  end
end

