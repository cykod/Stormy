class Stormy::Chunk

  def initialize(key,meta,page_meta,content)
    @key = key
    @meta = meta.merge(page_meta)
    @content = content

    @template = Stormy::Template.new(@key,@meta,@content) if @content
  end

  def valid?
    @template.present?
  end

  def render
    @template.render
  end

end
