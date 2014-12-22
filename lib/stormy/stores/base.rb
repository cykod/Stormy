require "yaml" 

module Stormy::Stores 

  class Base
    attr_reader :app

    def initialize
    end

    def register(val)
      @app = val
      self
    end

    # find the page that matches a key
    def page(key)
    end

    def layout(key)
    end

    # find the content that matches a category and a key
    def content(category,key)
    end

    # get all the content that matches a category
    def content_list(category, options)
    end

    def extract_content(body)
    end

    def extract(key,string, meta = {})
      return {} unless string.present?

      details = {}
      if(string =~ /\A(---\w*$\n.*?)^---\w*$\n(.*)\Z/m)
        begin 
          details = YAML.load($1).symbolize_keys
          details[:body] = $2
        rescue Exception => e
          raise "Error Parsing YAML #{key}: #{e.to_s}"
        end
      else
        details[:body] = string
      end

      details.merge!(meta)
      details[:permalink] = Stormy::Template.extract_segment(key)
      details[:key] = key
      details
    end

  end

end
