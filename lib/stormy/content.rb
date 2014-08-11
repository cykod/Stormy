class Stormy::Content < Stormy::Chunk

  def initialize(category,key,meta)
    key, meta, content = Stormy.cache.content(category,key) do
      Stormy.store.content(category,key)
    end

    super(key,meta,page_meta,content)
  end

end
