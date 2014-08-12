require 'digest/md5'

module Stormy::Caches 

  class Base

    def initialize
    end

    def content(category,key,options={},&block)
      data = self.get(category,key)
      if !data.nil?
        puts "Cache Hit:  #{category} #{key}"
        data
      else
        puts "Cache Miss: #{category} #{key}"
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

    def page_list(category,options = {}, &block)
      content_list("page",options,&block)
    end

    protected

    def hash_options(options)
      Digest::MD5.hexdigest(options.to_a.sort_by { |key,val| key }.to_json)
    end

    def get(category,key)
      raise "Unimplemented"
    end

    def put(category,key,data)
      raise "Unimplemented"
    end

  end
end

