class Stormy::Layout < Stormy::Chunk

  def render(child_template)
    raise "No Matching Template: #{@key}" unless @template
    output = child_template.render
    @details.merge!(child_template.details)
    @template.render do |section=nil|
      output
    end
  end

  def self.fetch(app,key,params)
    details = app.cache.layout(key) do 
      app.store.layout(key)
    end

    self.new(app,details,params)
  end

  
end
