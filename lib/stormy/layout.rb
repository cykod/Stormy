class Stormy::Layout < Stormy::Chunk

  def initialize(app,key,meta)
    key, page_meta, content = app.cache.layout(key) do 
      app.store.layout(key)
    end

    super(app,key,meta,page_meta,content)
  end

  def render(child_template)
    raise "No Matching Template: #{@key}" unless @template
    output = child_template.render
    @meta.merge!(child_template.meta)
    @template.render do |section=nil|
      output
    end
  end

  
end
