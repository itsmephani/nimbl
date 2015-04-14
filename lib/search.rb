require 'mechanize'

class Search
  
  def initialize args
    data = args
    @links = []
    @mechanize = Mechanize.new
    @mechanize.user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2'
    @start = 0
    @keyword = 'hair dryer'
    loop do
      get_page
      top_ads
      rhs_block
      search_results_google
      break if no_of_non_adwords_results < 11
      @start += 10
    end
  end

  def keyword
    @keyword
  end
  
  def rhs_block
    puts "..rhs_block"
    @no_of_adwords_right =  page.search('#mbEnd').search('ol > li').size
    @no_of_adwords_right.times do |i|
      link = (page.search('#mbEnd').search('ol > li')[i].search('h3>a').length > 0) && page.search('#mbEnd').search('ol > li')[i].search('h3>a').attribute('href').value || ''
      link = link.split('dest_url%3D')[1] || link.split('adurl=')[1] || link 
      puts "...#{@links << link}.."
    end
  end

  def search_results_google
    puts "search_results_google"
    @no_of_non_adwords_results =  page.search('li.g').size
    @no_of_non_adwords_results.times do |i|
      link = (page.search('li.g')[i].search('h3>a').length > 0) && page.search('li.g')[i].search('h3>a').try(:attribute, 'href').try(:value) || ''
      puts "...#{@links << link}"
    end
  end

  def no_of_non_adwords_results
    @no_of_non_adwords_results
  end

  def top_ads
    @no_of_adwords_top = page.search('#tads').search('ol>li').size
    @no_of_adwords_top.times do |i|
      link = (page.search('#tads').search('ol>li')[i].search('h3>a').length > 0) &&  page.search('#tads').search('ol>li')[i].search('h3>a').attribute('href').value || ''
      link = link.split('dest_url%3D')[1] || link.split('adurl=')[1] || link 
      display_url = page.search('#tads').search('ol>li')[i].search('cite').text
      puts "...#{@links << link}"
    end
  end

  def total_results_per_page
    total_advertisers + @no_of_non_adwords_results
  end

  def page
    @page
  end

  def links 
    @links
  end
  def get_page
    @page =  @mechanize.get('http://www.google.com/search?gcx=w&sourceid=chrome&ie=UTF-8&start='+@start.to_s+'&q='+ keyword.gsub(" ", "+") )
  end

  def content
    page.content
  end

  def total_advertisers
    @no_of_adwords_top + @no_of_adwords_right
  end

end
