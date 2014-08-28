class Stormy::Page < Stormy::Chunk

  def initialize(app, key,meta)
    key, page_meta, content = app.cache.page(key) do 
      app.store.page(key)
    end

    super(app,key,meta,page_meta,content)

    @layout = app.layout(@meta["layout"],@meta) if @meta["layout"]
  end

end
