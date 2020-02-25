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
    object = @@all.select{|a| a.name == item}
    if object == []
      object = Author.new(item)
      object
    end
    object
  end
  
  
  def self.get_authors_by_letter(letter)
    letter = letter.upcase
    author_list = []
    @@all.each do |author|
      if author.name.start_with? "#{letter}"
        author_list << author
      end
    end
    author_list
  end
  
  def self.author_by_letter_count(letter)
    count = @@all.count{|a| a.name.start_with? "#{letter}"}
    count
  end 
  
end