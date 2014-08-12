class Stormy::Stores::FileStore < Stormy::Stores::Base

  def initialize

  end

  def filename(base,path)
    files = Dir.glob(File.join(base,"#{path}.*"))
    if files[0] && !File.directory?(files[0])
      files[0]
    elsif File.directory?(File.join(base,path))
      files = Dir.glob("#{base}#{path}index.*")
      files[0]
    else 
      nil
    end
  end

  def layout(key)
    extract(*read("_layouts",key))
  end

  def page(key)
    extract(*read("public",key))
  end
  
  def content(category,key)
    extract(*read("_content/#{category}",key))
  end

  def read(base,path)
    file = filename(base,path)
    return [path, nil ] unless file
    fp = File.open(file,"rt")
    new_key =  file[base.length..-1]
    [ new_key, fp.read ]
  end

end
