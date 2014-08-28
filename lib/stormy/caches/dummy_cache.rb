class Stormy::Caches::DummyCache < Stormy::Caches::Base

  def get(category,key)
    nil
  end


  def put(category,key,value)
    value
  end

end
