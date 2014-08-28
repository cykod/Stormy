module Stormy::Engines 
  class Base
    def initialize(app)
      @app = app
    end
    
    def render(content,bindings)
      raise "Unsupported"
    end
  end
end
