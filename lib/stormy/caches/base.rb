require 'digest/md5'

module Stormy::Caches 

  class Base

    def initialize
    end

    def register(val)
      @app = val
      self
    end

    def content(category,key,options={},&block)
      data = self.get(category,key)
      if !data.nil?
        log "Cache Hit:  #{category} #{key}"
        data
      else
        log "Cache Miss: #{category} #{key}"
        self.put(category,key,yield(options))
      end
    end

    def page(key,&block)
      content("_pages",key,&block)
    end

    def layout(key,&block)
      content("_layouts",key,&block)
    end

    def content_list(category,options = {}, &block)
      content("list-#{category}",hash_options(options),&block)
    end

    def log(str)
      #puts str
    end

    protected

    def hash_options(options)
      Digest::MD5.hexdigest(options.to_a.sort_by { |key,val| key }.to_json)
    end

  end
end

