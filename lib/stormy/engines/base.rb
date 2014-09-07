module Stormy::Engines 
  class Base
    def initialize(app)
      @app = app
    end
    
    def render(body,bindings)
      raise "Unsupported"
    end
  end
end
