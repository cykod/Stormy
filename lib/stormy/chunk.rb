require "rack/mime"

class Stormy::Chunk
  attr_reader :meta

  def initialize(app,key,meta,page_meta,content)
    @app = app
    @key = key
    
    @meta = ActiveSupport::HashWithIndifferentAccess.new(app.defaults)
    @meta.merge!(page_meta) if page_meta
    @meta.merge!(meta) 
    
    @content = content

    @template = app.template(@key,@meta,@content) if @content
  end

  def valid?
    @template.present?
  end

  def render
    return  [ @layout ? @layout.render(@template) : @template.render,
              Rack::Mime.mime_type(File.extname(@meta["path"]), "text/html") ]
  end

end
