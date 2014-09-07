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
      if(string =~ /^(---$\n.*?)^---$\n(.*)/m)
        details = YAML.load($1).symbolize_keys
        details[:body] = $2
      else
        details[:body] = string
      end

      details.merge!(path_meta)
      details[:key] = key
      details
    end

  end

end
