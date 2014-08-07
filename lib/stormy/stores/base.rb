module Stormy::Stores 

  class Base

    def initialize
    end

    # find the page that matches a key
    def page(key)
    end

    # find the content that matches a category and a key
    def content(category,key)
    end

    # get all the content that matches a category and a key
    def content_list(category)
    end

    def extract_content(body)
    end

    def extract(string)
      if(body =~ /^(---$\n.*?)^---$\n(.*)/m)
        metadata = YAML.load($1) 
        content = $2
        [ metadata, content ]
      end
    end

  end

end
