class Stormy::Page < Stormy::Chunk

  def initialize(app, details, params)

    super(app,details,params)

    @layout = app.layout(@details["layout"],@details) if @details["layout"]
  end

  def self.fetch(app,key,params)
    details = app.cache.page(key) do 
      app.store.page(key)
    end

    self.new(app,details,params)
  end

end
