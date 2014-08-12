class Stormy::Layout < Stormy::Chunk

  def initialize(key)
    key, page_meta, content = Stormy.cache.layout(key) do 
      Stormy.store.layout(key)
    end

    super(key,{},page_meta,content)
  end

  def render(child_template)
    output = child_template.render
    @template.render do |section=nil|
      output
    end
  end

end
