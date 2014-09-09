require "fileutils"

class Stormy::Caches::FileCache < Stormy::Caches::Base

  def initialize(app)
    super
    @base_path =  app.join("tmp","cache")
    clean_path
  end

  protected

  def build_cache_key(category,key)
    path("#{category}--#{key.gsub("/","--")}.cache")
  end


  def get(category,key)
    filename = build_cache_key(category,key)
    if File.exists?(filename)
      File.read(filename)
    end
  end


  def put(category,key,value)
    filename = build_cache_key(category,key)
    File.open(filename,"wt") do |fp|
      fp.write(value)
    end
    value
  end

  def clean_path
    path_exists = File.directory?(@base_path)
    if path_exists
      FileUtils.rm Dir.glob(path("*.cache"))
    else
      FileUtils.mkpath(@base_path)
    end
  end

  def path(file)
    File.join(@base_path,file)
  end

end
