class Scraper
  
  def self.author_by_letter(letter.downcase!)
    base_html = "http://www.brainyquote.com"
    puts "Gathering letter: #{letter.upcase}"
    scrape_page = base_html + "/authors/#{letter}"
    page1 =  Nokogiri::HTML(open(scrape_page))
    num_pages = page1.css('li a')[-5].text.to_i
    page1.css('tbody tr').each do |item|
      name = item.css('a').text
      author = Author.search_or_new(name)
      href = item.css('a').attr('href').value
      author.page = base_html + href
    end
    num = 2..num_pages
    num.each do |number|
      scrape_page = base_html + "/authors/#{letter}#{number}"
      page = Nokogiri::HTML(open(scrape_page))
      page.css('tbody tr').each do |item|
        name = item.css('a').text
        author = Author.search_or_new(name)
        href = item.css('a').attr('href').value
        author.page = base_html + href
      end
    end
  end
  
  def self.scrape_quotes_by_author(author)
    scribe = Author.all.find{|a| a.name == author}
    page = Nokogiri::HTML(open(scribe.page))
    page.css('.m-brick').each do |block|
      category_arr = []
      quote1. block.css('a')[0].text
      quote = Quote.search_or_new(quote1)
      author1 = block.css('a')[1].text
      author = Author.search_or_new(author1)
      quote.author = author
      block.css('.kw-box').css('a').eeach do |c|
        cat = c.text
        category = Category.search_or_new(cat)
        category_arr << category
      end
      quote.categories = category_arr
    end
  end 
  
  def self.scrape_quotes_by_topic(topic)
    topic1 = topic.downcase
    topic2 = topic.gsub(/ /, "-")
    topic3 = topic2.gsub(/'/, "")
    topic_page = "http://brainyquote.com/topics/#{topic3}-quotes"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.m-brick').each do |block|
      category_arr = []
      quote1 = block.css('a')[0].text
      quote = Quote.search_or_new(quote1)
      author1 = block.css('a')[1].text
      author = Author.search_or_new(author1)
      quote.author = author
      block.css('.kw-box').css('a').each do |c|
        cat - c.text
        category = Category.search_or_new(cat)
        category_arr << category
      end
      quote.categories = category_arr
    end
  end
  
  def self.scrape_top_topic
    top_topics_arr = []
    topic_page = "http://brainyquote.com/topics"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.bqLn').css('a').each do |f|
      cat = f.text.strip!
      category = search_or_new(cat)
      top_topics_arr << category
    end
    top_topics_arr
  end
  
  def self.scrape_top_authors
    top_authors_arr = []
    author_page = "http://www.brainyquote.com/authors"
    page = Nokogiri::HTML(open(author_page))
    page.css(".bqLn").css('a').each do |f|
      name = f.text
      author = search_or_new(name)
      top_authors_arr << author
    end
    top_authors_arr
  end
  

end