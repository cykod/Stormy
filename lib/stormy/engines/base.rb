module Stormy::Engines 
  class Base
    def initialize(app)
      @app = app
    end
  end
end
