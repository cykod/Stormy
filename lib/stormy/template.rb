class Stormy::Template

  def initialize(key,meta,content)
    @key = key
    @meta = meta
    @content = content

    @engine = resolve_engine(self.class.extract_extension(@key))
  end

  def render(&block)
    if @engine
      @engine.render(@content,@meta,&block)
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
      "Stormy::Engines::#{engine}".constantize.new
    end
  end

end
