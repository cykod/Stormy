class Stormy::Engines::Erb  < Stormy::Engines::Base
  def render(content,bindings)
    @engine = ::ERB.new(content, nil, "<>")
  end
end
