class Stormy::Caches::MemoryCache < Stormy::Caches::Base

  def initialize(options = {})
    @data = {}
  end

  protected

  def build_cache_key(category,key)
    "#{category}--#{key.gsub("/","--")}"
  end


  def get(category,key)
    @data[build_cache_key(category,key)]
  end


  def put(category,key,value)
    @data[build_cache_key(category,key)] = value
  end

end
