require "yaml" 

module Stormy::Stores 

  class Base

    def initialize(app)
      @app = app
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
    def content_list(category)
    end

    def extract_content(body)
    end

    def extract(key,string, path_meta = {})
      return {} unless string.present?

      details = {}
      if(string =~ /^(---\w*$\n.*?)^---\w*$\n(.*)/m)
        begin 
          details = YAML.load($1).symbolize_keys
          details[:body] = $2
        rescue Exception => e
          raise "Error Parsing YAML #{key}: #{e.to_s}"
        end
      else
        details[:body] = string
      end

      details.merge!(path_meta)
      details[:permalink] = Stormy::Template.extract_segment(key)
      details[:key] = key
      details
    end

  end

end
