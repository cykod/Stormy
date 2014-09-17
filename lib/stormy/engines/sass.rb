require "sass"

class Stormy::Engines::Sass < Stormy::Engines::Base

  def render(body,bindings,&block)
    engine = Sass::Engine.new(body, 
                              syntax: :scss,
                              load_paths: [ @app.join("public/assets") ]
                             )
    engine.render
  end
end
