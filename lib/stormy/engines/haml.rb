require "haml"

class Stormy::Engines::Haml < Stormy::Engines::Base

  def initialize
  end

  def render(content,bindings,&block)
    engine = Haml::Engine.new(content)
    engine.render(Object.new, bindings,&block)
  end
end
