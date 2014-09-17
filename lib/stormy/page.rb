class Stormy::Page < Stormy::Chunk

  def initialize(app, details, params)

    super(app,details,params)

    @layout = app.layout(@details["layout"],@details) if @details["layout"]
    @template.content = resolve_content if details[:content] && @template
  end

  def self.fetch(app,key,params)
    details = app.cache.page(key) do 
      app.store.page(key)
    end

    self.new(app,details,params)
  end

  def render(status = nil)
    output =  @layout && mime_type == "text/html" ? @layout.render(@template) : @template.render
    if details[:redirect]
      [status || 301, {'Content-Type' => 'text','Location' => details[:redirect]}, ['301 found'] ]
    else
      [status || 200, {'Content-Type' => mime_type }, [ output ] ]
    end
  end

  def mime_type
    @mime_type ||= Rack::Mime.mime_type(File.extname(details["key"]),"text/html")
  end

end
