class Stormy::Content < Stormy::Chunk

  def initialize(app,details)
    super(app,details)
  end

  def render
    resolve_content if details[:content]
    @details.merge({
      body: @template.render
    })
  end

  def self.fetch(app, category, key)
    details = app.cache.content(category,key) do
      app.store.content(category,key)
    end

    self.new(app,details)
  end
end
