class StormyApp

  attr_reader :root, :cache, :store, :defaults, :options, :page_not_found

  def initialize(options)
    @options = options
    @root = options[:root] || raise("Missing :root config")
    @cache = (options[:cache] || Stormy::Caches::DummyCache).new(self)
    @store = (options[:store] || Stormy::Stores::FileStore).new(self)
    @page_not_found = (options[:page_not_found] || "/404")
    @defaults =  YAML.load_file(File.join(root, options[:defaults] || 'config.yml')) rescue {}
    @defaults.symbolize_keys!
  end

  def page(path,params={})
    Stormy::Page.fetch(self,path,params)
  end

  def layout(path,params={})
    Stormy::Layout.fetch(self,path,params)
  end

  def content(category,key)
    Stormy::Content.fetch(self,category,key)
  end

  def content_list(category,options={})
    Stormy::ContentList.fetch(self,category,options)
  end

  def template(key,details)
    Stormy::Template.new(self,key,details)
  end

  def join(*args)
    sanitized_args = [ self.root ] + args.map { |arg| arg.gsub("..","") }
    File.join(*sanitized_args)
  end

end
