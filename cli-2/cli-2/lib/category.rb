class Category
  attr_accessor :category
  
  @@all = []
  
  def initialize(cat)
    @category = cat
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.search_or_new(item)
    object = @@all.find{|a| a.category == item}
    if object == nil 
      object = Category.new(item)
    end 
    object
  end
end