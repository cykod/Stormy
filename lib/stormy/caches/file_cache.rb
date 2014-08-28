class Stormy::Caches::FileCache < Stormy::Caches::Base

  def initialize(app)
    super
    @base_path =  File.join(app.root,"tmp","cache")
    @path_exists = File.exists?(@base_path)
  end

  protected

  def build_cache_key(category,key)
    "#{category}--#{key.gsub("/","--")}"
  end


  def get(category,key)
    create_path unless @path_exists
  end


  def put(category,key)
    create_path unless @path_exists

  end

  def create_path
    File.mkpath(@base_path)
    @path_exists = true
  end

end
