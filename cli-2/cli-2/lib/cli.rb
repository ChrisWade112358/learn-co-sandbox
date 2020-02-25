class CLI
  
  def call
    CLI.main_menu
  end
  
  def self.main_menu
    puts
    puts
    puts
    puts "       ----------------------------------------------".colorize(:yellow)
    puts
    puts "                        Qoutes!  ".colorize(:yellow)
    puts
    puts "       ----------------------------------------------".colorize(:yellow)
    puts
    puts
    puts "       ----------------------------------------------".colorize(:cyan)
    puts
    puts "                       Main Menu                     ".colorize(:cyan)
    puts "       ----------------------------------------------".colorize(:cyan)
    puts
    puts "       1. Browse authors alphabetically.".colorize(:yellow)
    puts "       2. View a random list of top authors to select from.".colorize(:yellow)
    puts "       3. Browse by topic".colorize(:yellow)
    puts "       4. View a random list of top topics to select from".colorize(:yellow)
    puts 
    puts
    puts "                 Please choose a number 1-4".colorize(:green)
    puts "        You can type \"exit\" at any time to exit the program.".colorize(:green)
    
    while true
      input = gets.chomp!
      if input == "exit"
        puts "Thank's for visiting. Good bye.".colorize(:magenta)
        exit!
      elsif input.to_i > 0 && input.to_i < 5
        @input = input.to_i
      else
        puts "Please enter a valid number or type exit.".colorize(:magenta)
      end
      case @input
      when 1 
        letter = CLI.choose_letter
        CLI.display_authors_by_letter(letter, start = 0, stop = 24)
      when 2
        CLI.display_random_top_authors
      when 3
        CLI.display_topics_list
      when 4 
        CLI.random_top_topics
      end
    end
  end
  
  def self.display_authors_by_letter(letter, start = 0, stop = 24)
    authors_list = Author.get_authors_by_letter(letter)
    answer = 1
    error_holder = ""
    while answer == 1
      authors_list[start..stop].each_with_index do |author, index|
        puts "#{index + 1}| #{author.name}"
      end
      puts
      puts error_holder
      puts "Enter 1 to select the author and see quotes from that author.".colorize(:green)
      puts "Enter 2 for the next 25 authors.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to select another letter.".colorize(:green)
      puts "Enter 5 to return to the Main Menu.".colorize(:green)
      puts "Enter \"exit\" to exit the program.".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thank's for visiting. Good bye.".colorize(:magenta)
        exit!
        elsif input.to_i > 0 && input.to_i <= 5 
          @input = input.to_i
        else
          puts = "Please enter a valid number or type exit."
      end
      case @input
      when 1
        puts "Enter author number."
        a = gets.strip!.to_i
        author = authors_list[start + a - 1]
        author.display_quotes_by_author
      when 2
        max = Author.author_by_letter_count(letter)
        if stop >= max
          error_holder = "You're at the end of the list. Please make another selection."
          answer = 1
        else
          start += 25
          stop += 25
          answer = 1
        end
      when 3
        if start == 0 
          letter = CLI.choose_letter
          CLI.display_authors_by_letter(letter)
        else
          start -= 25
          stop -= 25
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
  
  def self.display_random_top_authors
    authors_list = Scraper.scrape_top_authors
    error_holder = ""
    answer = 1
    while answer == 1
      rand_top_authors = authors_list.sample(25)
      rand_top_authors.each_with_index do |author, index|
        puts "#{index +1}| #{author.name}"
      end
      puts
      puts error_holder
      puts "Enter 1 to select an author you would like to see quotes by.".colorize(:green)
      puts "Enter 2 to Spin Again!".colorize(:green)
      puts "Enter 3 to go back to the Main Menu.".colorize(:green)
      puts "Enter \"exit\" to exit the program".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Good bye.".colorize(:magenta)
        exit! 
      elsif input.to_i > 0 && input.to_i <= 3 
        @input = input.to_i
      else
        puts "Please enter a valid number or type exit."
      end
      case @input
      when 1
        puts "Enter author number."
        a = gets.strip!.to_i
        author = rand_top_authors[a - 1]
        CLI.display_quotes_by_author(author)
      end
    end
  end
  
  def display_topics_list
    topipcs_arr = Scraper.scrape_top_topics
    start = 0
    stop = 24
    answer = 1
    error_holder = ""
    while answer = 1
      topics_arr[start..stop].each_with_index do |topic, index|
        puts "#{index + 1}| #{topic.category}"
      end
      puts
      puts error_holder
      puts "Enter 1 to select the category and see quotes from that category.".colorize(:green)
      puts "Enter 2 for the next 25 categories.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to go back to the main menu.".colorize(:green)
      puts "Enter exit to exit the program.".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thank's for visiting. Good bye.".colorize(:magenta)
        exit!
        elsif input.to_i > 0 && input.to_i <= 4 
          @input = input.to_i
        else
          error_holder = "Please enter a valid number or type exit."
          answer = 1
        end
      case @input
      when 1
        puts "Enter a category number."
        num = gets.strip!.to_i
        category = topics_arr[start + a - 1]
        category.display_quotes_by_category
      when 2
        if stop + 25 > topics_arr.size
          error_holder = "You're at the end of the list. Please make another selection."
          answer = 1
        else
          start += 25
          stop  += 25
          answer = 1
        end
      when 3
        if start == 0
          error_holder = "This is the beginning of the list. If you would like to go back to the Main Menu, select number 4."
          answer = 1
        else
          start -= 25
          stop -= 25
          answer = 1
        end
      when 4
        CLI.main_menu
      end
    end
  end
  
  def random_top_topics
    topics_arr = Scraper.scrape_top_topics
    answer = 1
    error_holder = ""
    while answer == 1
      rand_top_topics = topics_arr.sample(10)
      rand_top_topics.each_with_index do |topic, index|
        puts "#{index + 1}| #{topic.category}"
      end
      puts
      puts error_holder
      puts "Enter 1 to select a category you would like to see quotes from.".colorize(:green)
      puts "Enter 2 to Spin Again!".colorize(:green)
      puts "Enter 3 to go back to the main menu.".colorize(:green)
      puts "Enter exit to exit the program.".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Good bye.".colorize(:magenta)
        exit! 
      elsif input.to_i > 0 && input.to_i < 5 
        @input = input.to_i
      else
        error_holder = "Please enter a valid number or type exit."
        answer = 1
      end
      case @input
      when 1 
        puts "Enter a category number."
        num = gets.strip!.to_i 
        category = topics_arr[num - 1]
        category.display_quotes_by_category
      when 2
        answer = 1
      when 3
        CLI.main_menu
      end 
    end 
  end
  
  
end           
          
    