require "kramdown"

class Stormy::Engines::Markdown < Stormy::Engines::Base

  def render(body,bindings,&block)
    Kramdown::Document.new(body).to_html
  end
end
