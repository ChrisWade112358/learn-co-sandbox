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
  
  def display_qotes_by_author
    Scraper.scrape_quotes_by_author(self.page)
    quotes_list = Quote.all.select{|a| a.author = self.name}
    answer = 1
    start = 0
    stop = 9
    error_holder = ""
    while answer = 1
      quotes_list[start..stop].each_with_index do |quote, index|
        puts "#{index + 1}"
        puts "#{quote.quote}"
        puts 
        puts "#{self.name}"
        puts "Categories:".colorize(:yellow)
        quote.categories.each_with_index{|item, index| puts "#{index + 1}| #{item.category}"}
        puts "_______________________________________________________________________"
      end
      puts
      puts error_holder
      puts "Enter 1 to select a category from a particular quote.".colorize(:green)
      puts "Enter 2 for the next 10 quotes.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to browse another letter.".colorize(:green)
      puts "Enter 5 to go back to the main menu".colorize(:green)
      puts "Enter \"exit\" to exit the program".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Good bye.".colorize(:magenta)
        exit!
      elsif input.to_i > 0 && input.to_i <= 5 
        @input = input.to_i
      else
        puts "Please enter a valid number or type exit."
      end
      case @input
      when 1
        puts "Enter a quote number."
        qnum = gets.strip!.to_i
        puts "Enter a category number from the quote."
        cnum = gets.strip!.to_i
        q = quotes_list[qnum - 1]
        top = q.categories[cnum - 1]
        top.display_quotes_by category
      when 2
        if stop + 10 > quotes_list.count
          error_holder = "You're at the end of the list. Please make another selection."
          answer = 1
        else
          start += 10
          stop += 10
          answer = 1
        end
      when 3
        if start == 0
          error_holder = "This is the beginning of the list. If you would like to go back to the Main Menu, select number 4."
          answer = 1
        else
          start -= 10
          stop -= 10
          answer = 1
        end
      when 4
        letter = CLI.choose_letter
        CLI.display_authors_by_letter(letter)
      when 5
        CLI.main_menu
      end
    end
  end
  
end