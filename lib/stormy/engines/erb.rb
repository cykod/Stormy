class Stormy::Engines::Erb  < Stormy::Engines::Base

  def initialize
  end

  def render(content,bindings)
    @engine = ::ERB.new(content, nil, "<>")
  end
end
