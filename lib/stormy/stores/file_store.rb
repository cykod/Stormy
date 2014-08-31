class Stormy::Stores::FileStore < Stormy::Stores::Base

  def filename(base,path)
    files = Dir.glob(@app.join(base,"#{path}.*"))
    if valid_file?(files[0])
      return files[0], {}
    elsif File.directory?(@app.join(base,path))
      files = Dir.glob(@app.join(base,path,"index.*"))
      return files[0], {}
    else 
      # split by separators and see if there we can match the pieces to segments
      match_segments(base,path)
    end
  end

  def layout(key)
    extract(*read("layouts",key))
  end

  def page(key)
    extract(*read("public",key))
  end
  
  def content(category,key)
    extract(*read("content/#{category}",key))
  end

  def read(base,path)
    file, path_meta = filename(base,path)
    return [path, nil ] unless file
    fp = File.open(file,"rt")
    new_key =  file[base.length..-1]
    [ new_key, fp.read, path_meta ]
  end

  def match_segments(base,path)
    path_pieces = path.split("/").reject(&:blank?)
    permalink_piece = path_pieces.pop
    partial_path = path_pieces.join("/")
    if File.directory?(@app.join(base,partial_path))
      files = Dir.glob(@app.join(base,partial_path,":*.*"))
      if valid_file?(files[0])
        extension = File.extname(files[0])
        keyname = File.basename(files[0], extension)[1..-1]
        return files[0], { keyname => permalink_piece }.symbolize_keys
      end
    end
    nil
  end


  def valid_file?(filename)
    filename.present? && !File.directory?(filename)
  end

end
