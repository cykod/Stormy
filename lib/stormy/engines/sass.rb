require "sass"

class Stormy::Engines::Sass < Stormy::Engines::Base

  def render(body,bindings,&block)
    engine = Sass::Engine.new(body, :syntax => :scss)
    engine.render
  end
end
