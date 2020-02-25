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
    

end