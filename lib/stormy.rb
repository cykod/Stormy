module Stormy

  def self.cache=(val)
    @@cache = val
  end

  def self.store=(val)
    @@store = val
  end

  def self.root=(val)
    @@root = val
  end


  def self.cache
    @@cache
  end

  def self.store
    @@store
  end

  def self.root
    @@root
  end

end

require_relative 'stormy/caches/base'
require_relative 'stormy/caches/file_cache'

require_relative 'stormy/chunk'
require_relative 'stormy/content'
require_relative 'stormy/page'

require_relative 'stormy/stores/base'
require_relative 'stormy/stores/file_store'

require_relative 'stormy/template'

Stormy.cache = Stormy::Caches::FileCache.new
Stormy.store = Stormy::Stores::FileStore.new
