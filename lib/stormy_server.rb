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
      output, content_type = render_page(path)
      if output
        [200, {"Content-Type" => content_type}, [ output ] ] 
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
      @error_page = @app.page("/404", { "path" => "/404" })
      if @error_page.valid? 
        @error_page.render
      end
    end
  end
end

