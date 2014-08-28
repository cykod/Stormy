class Stormy::Content < Stormy::Chunk

  def initialize(app,category,key,meta)
    key, meta, content = app.cache.content(category,key) do
      app.store.content(category,key)
    end

    super(app,key,meta,page_meta,content)
  end

end
