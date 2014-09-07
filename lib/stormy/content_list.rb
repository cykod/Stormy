class Stormy::ContentList 

  attr_reader :items

  def initialize(app,items)
    @items = items.map do |item|
      Stormy::Content.new(app,item).render
    end
  end

  def self.fetch(app,category,options = {})
    items = app.cache.content_list(category,options) do
      app.store.content_list(category,options)
    end

    self.new(app,items)
  end
end
