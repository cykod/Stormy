require "rack"
require "rack/mime"
require_relative "lib/stormy"

class StormyApp
  def initialize
    @file_server = Stormy::Static.new(File.join(Stormy.root,"public"))
  end

  def call(env)
    render(::Rack::Utils.unescape(env['PATH_INFO']))
  end


  def render(path)
    if @file_server.can_serve?(path)
      @file_server.serve(path)
    else
      output, content_type = render_page(path)
      [200, {"Content-Type" => content_type}, [ output ] ] 
    end
  end

  def render_page(path)
    @page = Stormy::Page.new(path,{ "path" =>  path })

    if @page.valid?
      @page.render
    else
      @error_page = Stormy::Page.new("/404", {})
      @error_page.render
    end
  end
end

