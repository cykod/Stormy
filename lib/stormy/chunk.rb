require "rack/mime"

class Stormy::Chunk
  attr_reader :details, :content, :body

  def initialize(app,details,params={})
    @app = app
    
    @params = params
    if details
      @details = ActiveSupport::HashWithIndifferentAccess.new(app.defaults)
      @details.merge!(details) 
    
      @body = details[:body]
      @template = app.template(details[:path],@details) if @body
    else
      @details = {}
    end
    @content = {}
  end


  def valid?
    @template.present? && !@invalid_content
  end


  def resolve_content
    pieces = details[:content]
    pieces = [ pieces ] unless pieces.is_a?(Array)
    pieces.each do |piece|
      if !resolve_piece(piece)
        @invalid_content = true
      end
    end
    self.content
  end

  def resolve_piece(piece)
    name = (piece[:name] || piece[:type]).to_sym
    type = piece[:type]
    if piece[:key].present?
      resolve_content_piece(name,type,piece)
    else
      resolve_content_list(name,type,piece)
    end
  end

  def resolve_content_piece(name,type,piece)
    key = if piece[:key].is_a?(Symbol)
            details[piece[:key]]
          else
            piece[:key]
          end
    content_chunk = @app.content(type,key)

    if content_chunk && content_chunk.valid?
      content[name] = content_chunk.render
    end
  end

  def resolve_content_list(name,type,piece)
    content_list = @app.content_list(type,piece)
    content[name] = content_list.items
  end

end
