module Stormy

  def self.cache=(val)
    @@cache = val
  end

  def self.store=(val)
    @@cache = val
  end


  def self.cache

  end

  def self.store

  end

end

require_relative 'stormy/cache'
require_relative 'stormy/chunk'
require_relative 'stormy/content'
require_relative 'stormy/page'
require_relative 'stormy/store'
require_relative 'stormy/template'

Stormy.cache = Stormy::Caches::FileCache.new
Stormy.store = Stormy::Stores::FileStore.new
