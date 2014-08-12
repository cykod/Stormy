class Stormy::Static 

  def initialize(root)
    @root = root
    @rack_file = Rack::File.new(root)
  end

  def can_serve?(path)
    extension = Stormy::Template.extract_extension(path)

    if !Stormy::Template.rendered_extension?(extension)
      File.exists?(File.join(@root, path))
    end
  end

  def serve(path)
    @rack_file.call("PATH_INFO" => path, "REQUEST_METHOD"=>"GET")
  end

end
