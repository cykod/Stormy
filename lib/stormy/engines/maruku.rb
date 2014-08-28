require "maruku"

class Stormy::Engines::Maruku < Stormy::Engines::Base

  def render(content,bindings,&block)
    ::Maruku.new(content).to_html
  end
end
