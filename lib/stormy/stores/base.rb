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

    # get all the content that matches a category and a key
    def content_list(category)
    end

    def extract_content(body)
    end

    def extract(key,string, path_meta = {})
      return [ key, {}, nil ] unless string.present?
      if(string =~ /^(---$\n.*?)^---$\n(.*)/m)
        metadata = YAML.load($1).symbolize_keys
        content = $2
        [ key, path_meta.merge(metadata), content ]
      else
        [ key, path_meta, string ]
      end
    end

  end

end
