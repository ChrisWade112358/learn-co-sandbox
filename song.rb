require

class Song 
  attr_accessor :title, :length 
  attr_reader: id 
  @@all = []
  
  def initialize(title, lenght, id)
    @title = title
    @length = length
    @id = id
  end
  
  
end