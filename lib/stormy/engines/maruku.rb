require "maruku"

class Stormy::Engines::Maruku < Stormy::Engines::Base

  def render(body,bindings,&block)
    ::Maruku.new(body).to_html
  end
end
