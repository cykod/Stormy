require "rack/mime"

class Stormy::Chunk

  def initialize(key,meta,page_meta,content)
    @key = key
    @meta = page_meta ?  meta.merge(page_meta) : {}
    @content = content

    @layout = Stormy::Layout.new(@meta["layout"]) if @meta["layout"]
    @template = Stormy::Template.new(@key,@meta,@content) if @content
  end

  def valid?
    @template.present?
  end

  def render
    return  [ @layout ? @layout.render(@template) : @template.render,
              Rack::Mime.mime_type(File.extname(@meta["path"]), "text/html") ]
  end

end
