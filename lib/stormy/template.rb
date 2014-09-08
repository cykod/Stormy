class Stormy::Template

  attr_reader :details
  attr_accessor :content

  def initialize(app,key,details)
    @app = app
    @details = details
    @key = key
    @body = details["body"]

    @engine = resolve_engine(self.class.extract_extension(@key))
  end

  def render(&block)
    if @engine
      @engine.render(@body,resolve_bindings,&block)
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
      meta: @details
    }.merge(@content || {})
  end

end
