require "rack"
require "rack/mime"

class StormyServer
  def initialize(config_options)
    @app = StormyApp.new(config_options)
    @file_server = Stormy::Static.new(File.join(@app.root,"public"))
  end

  def call(env)
    render(::Rack::Utils.unescape(env['PATH_INFO']))
  end


  def render(path)
    if @file_server.can_serve?(path)
      @file_server.serve(path)
    else
      output = render_page(path)
      if output
        output
      else
        [404, {"Content-Type" => "text/html"}, [ "Page Not Found" ] ] 
      end
    end
  end

  def render_page(path)
    @page = @app.page(path,{ "path" =>  path })

    if @page.valid?
      @page.render
    else
      @error_page = @app.page(@app.page_not_found, { "path" => @app.page_not_found })
      if @error_page.valid? 
        @error_page.render(404)
      end
    end
  end
end

