class Stormy::Engines::Erb  < Stormy::Engines::Base
  def render(body,bindings)
    @engine = ::ERB.new(body, nil, "<>")
  end
end
