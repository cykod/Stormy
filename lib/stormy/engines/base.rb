module Stormy::Engines 
  class Base
    def render(content,bindings)
      raise "Unsupported"
    end
  end
end
