class Stormy::Template

  attr_reader :meta

  def initialize(app,key,meta,content)
    @app = app
    @key = key
    @meta = meta
    @content = content

    @engine = resolve_engine(self.class.extract_extension(@key))
  end

  def render(&block)
    if @engine
      @engine.render(@content,resolve_bindings,&block)
    else
      nil
    end
  end

  protected

  @@engines = {
    "md" => "Maruku",
    "haml" => "Haml",
    "txt"  => "Text",
    "html" => "Html",
    "erb" => "Erb",
    "scss" => "Sass"
  }

  @@supported_extensions = @@engines.keys

  def self.rendered_extension?(extension)
    @@supported_extensions.include?(extension)
  end
  

  def self.extract_extension(key)
    return "txt" unless key.include?(".")
    key.split(".")[-1].to_s.downcase
  end

  def resolve_engine(extension)
    engine = @@engines[extension]
    if !engine.nil?
      "Stormy::Engines::#{engine}".constantize.new(@app)
    end
  end

  def resolve_bindings
    { 
      meta: @meta
    }
  end

end
