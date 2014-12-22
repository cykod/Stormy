class Stormy::Stores::FallbackStore < Stormy::Stores::Base

  def initialize(first_store, second_store)
    @first_store = first_store
    @second_store = second_store
  end

  def register(app)
    @app = app
    @first_store.register(app)
    @second_store.register(app)
    self
  end

  def layout(key)
    either("layout",key)
  end

  def page(key)
    either("page",key)
  end

  def content(category,key)
    either('content',category,key)
  end

  def content_list(category, options)
    either('content_list',category,options)
  end


  def either(type,*args)
    @first_store.send(type,*args) ||
      @second_store.send(type,*args)
  end

end
