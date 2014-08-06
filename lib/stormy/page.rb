class Stormy::Page

  def initialize(key)
    key, page_meta, content = Stormy.cache.page(key) do 
      Stormy.store.page(key)
    end


    super(key,meta,page_meta,content)
  end

end
