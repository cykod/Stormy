class Stormy::Engines::Erb  < Stormy::Engines::Base

  def render(body,bindings)
    engine = ::ERB.new(body, 0, "<>")
    engine.result OpenStruct.new(bindings).instance_eval { binding }
  end

end
