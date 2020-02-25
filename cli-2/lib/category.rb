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
    object = @@all.select{|a| a == item}
    if object == []
      object = Category.new(item)
      object
    end
    object
  end
end