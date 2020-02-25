class Author 
  attr_accessor :name, :page
  
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
  end
  
  def self.all
    @@all
  end
  
   def self.search_or_new(item)
    object = @@all.select{|a| a == item}
    if object == []
      object = Author.new(item)
      object
    else
      object
    end
  end

end