require 'active_support/all'

module Stormy

  VERSION = "0.0.1"

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

require_relative 'stormy/static'

require_relative 'stormy/caches/base'
require_relative 'stormy/caches/file_cache'
require_relative 'stormy/caches/memory_cache'

require_relative 'stormy/chunk'
require_relative 'stormy/content'
require_relative 'stormy/page'
require_relative 'stormy/layout'

require_relative 'stormy/stores/base'
require_relative 'stormy/stores/file_store'

require_relative 'stormy/engines/base'
require_relative 'stormy/engines/maruku'
require_relative 'stormy/engines/erb'
require_relative 'stormy/engines/haml'
require_relative 'stormy/engines/sass'

require_relative 'stormy/template'

require_relative "stormy_app"

Stormy.cache = Stormy::Caches::MemoryCache.new
Stormy.store = Stormy::Stores::FileStore.new
