class Stormy::Page < Stormy::Chunk

  def initialize(key,meta)
    key, page_meta, content = Stormy.cache.page(key) do 
      Stormy.store.page(key)
    end

    super(key,meta,page_meta,content)
  end

end
