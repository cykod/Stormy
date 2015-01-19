class Stormy::Stores::FileStore < Stormy::Stores::Base


  def layout(key)
    read_key("layouts",key)
  end

  def page(key)
    read_key("public",key)
  end
  
  def content(category,key)
    read_key("content/#{category}",key)
  end

  def content_list(category, options)
    base = @app.join("content",category)
    options = options.symbolize_keys
    return nil unless File.directory?(base)
    files = Dir.glob(File.join(base,"*.*"))
    files = files.map { |file| read_file(file, File.basename(file)) }
    if options[:order] 
      files = files.sort_by { |fl| fl[options[:order].to_sym] || 0 }
      files = files.reverse if options[:desc]
    end
    files = files[0..(options[:limit] - 1)] if options[:limit]
    files
  end


  def read_key(base,path)
    file, path_meta = lookup_filename(base,path)
    return nil unless file
    read_file(file,path,path_meta)
  end

  def lookup_filename(base,path)
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

  def read_file(file, path, path_meta = {})
    fp = File.open(file,"rt:UTF-8")
    path_meta[:path] = file.to_s
    extract(path, fp.read, path_meta)
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
        return files[0], { keyname.to_sym => permalink_piece }
      end
    end
    nil
  end


  def valid_file?(filename)
    filename.present? && !File.directory?(filename)
  end

end
