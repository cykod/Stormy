class Stormy::Stores::FileStore < Stormy::Stores::Base

  def initialize

  end

  def page(key)
    extract(read("public",key))
  end
  
  def content(category,key)
    extract(read("_content/#{category}",key))
  end

  def read(base,path)
    file = File.open(File.join(Stormy.root,base,path),"rt")
    file.read
  end

end
