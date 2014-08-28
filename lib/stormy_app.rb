
class StormyApp

  attr_reader :root, :cache, :store, :defaults, :options

  def initialize(options)
    @options = options
    @root = options[:root] || raise("Missing :root config")
    @cache = (options[:cache] || Stormy::Caches::DummyCache).new(self)
    @store = (options[:store] || Stormy::Stores::FileStore).new(self)
    @defaults =  YAML.load_file(File.join(root, options[:defaults] || 'config.yml')) rescue {}
  end

  def page(path,meta)
    Stormy::Page.new(self,path,meta)
  end

  def layout(path,meta)
    Stormy::Layout.new(self,path,meta)
  end

  def template(path,meta,content)
    Stormy::Template.new(self,path,meta,content)
  end

end
