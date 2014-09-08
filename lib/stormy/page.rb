class Stormy::Page < Stormy::Chunk

  def initialize(app, details, params)

    super(app,details,params)

    @layout = app.layout(@details["layout"],@details) if @details["layout"]
  end

  def self.fetch(app,key,params)
    details = app.cache.page(key) do 
      app.store.page(key)
    end

    self.new(app,details,params)
  end

  def render
    @template.content = resolve_content if details[:content]
    output =  @layout ? @layout.render(@template) : @template.render
    if details[:redirect]
      [301, {'Content-Type' => 'text','Location' => details[:redirect]}, ['301 found'] ]
    else
      [200, {'Content-Type' => mime_type }, [ output ] ]
    end
  end

  def mime_type
    Rack::Mime.mime_type(File.extname(details["key"]),"text/html")
  end

end
