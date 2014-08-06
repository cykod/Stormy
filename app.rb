require "rack"
require_relative "lib/stormy"

class StormyApp
  def call(env)
    output = render(env['PATH_INFO'])
    [200, {"Content-Type" => "text/html"}, output ] 
  end

  def render(path)
    # find a page that matches
    @page = Stormy::Page.new(path)

    if @page.valid?
      @page.render
    else
      @page = Stormy::Page.new("404")
      @page.render
    end
  end
end

