require "sass"

class Stormy::Engines::Sass < Stormy::Engines::Base

  def initialize
  end

  def render(content,bindings,&block)
    engine = Sass::Engine.new(content, :syntax => :scss)
    engine.render
  end
end
