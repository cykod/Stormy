require "haml"

class Stormy::Engines::Haml < Stormy::Engines::Base

  def render(body,bindings,&block)
    engine = Haml::Engine.new(body)
    engine.render(Object.new, bindings,&block)
  end
end
