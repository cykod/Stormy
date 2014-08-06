class Stormy::Template

  def initialize(key,meta,content)
    @key = key
    @meta = meta
    @content = content

    @engine = resolve_engine(extract_extension(@key))
  end

  def render
    if @engine
      @engine.render(@content,@meta)
    else
      nil
    end
  end

  protected

  @@engines = {
    "md" => "Maruku",
    "haml" => "Haml",
    "txt" => "Text",
    "html" => "Html",
    "erb" => "Erb",
    "less" => "Less",
    "scss" => "Sass",
    "css" => "Css"
  }

  def extract_extension(key)
    return "txt" unless key.include?(".")
    key.split(".")[-1].to_s.downcase
  end

  def resolve_engine(extension)
    engine = @@engines[extension]
    if engine.present?
      "Stormy::Engines::#{engine}".constantize.new
    end
  end

end
