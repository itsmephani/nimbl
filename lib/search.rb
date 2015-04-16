require 'mechanize'

class Search
  
  def initialize keywords    
    @links = []
    @result = {}
    @mechanize = Mechanize.new
    @mechanize.user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2'
    keywords.each do |keyword|
      @start = 0      
      @keyword = keyword
      loop do
        get_page        
        break if Keyword.exists?({keyword: @keyword})
        @current_keyword = store_keyword if @start == 0
        @current_page = create_page
        result[:page_id] = @current_page.id
        top_ads
        rhs_block
        search_results_google
        update_page
        break if no_of_non_adwords_results < 10
        @start += 10
      end
    end
  end

  def get_page
    @page =  @mechanize.get('http://www.google.com/search?gcx=w&sourceid=chrome&ie=UTF-8&start='+@start.to_s+'&q='+ keyword.gsub(" ", "+") )    
    rescue Exception => e
      puts e.message
  end

  def store_keyword
    results_count = page.search('#resultStats').text.split(" ")[1]
    time_taken = page.search('#resultStats').text.split(" ")[3][1..-1].to_s + " seconds"
    Keyword.create({keyword: @keyword, results_count: results_count, time_taken: time_taken})
  end

  def create_page
    Page.create({keyword_id:  @current_keyword.id, start: @start})
  end

  def top_ads
    @no_of_adwords_top = page.search('#tads').search('ol>li').size
    @no_of_adwords_top.times do |i|
      link = (page.search('#tads').search('ol>li')[i].search('h3>a').length > 0) &&  page.search('#tads').search('ol>li')[i].search('h3>a').attribute('href').value || ''
      result[:link] = link.split('dest_url%3D')[1] || (link.split('adurl=')[1] && link.split('adurl=')[1].split('%3F')[0]) || link
      result[:display_url] = (page.search('#tads').search('ol>li')[i].search('cite').length > 0) && page.search('#tads').search('ol>li')[i].search('cite').text || ''      
      result[:is_ad] = true
      store_result
    end
  end
  
  def rhs_block
    @no_of_adwords_right =  page.search('#mbEnd').search('ol > li').size
    @no_of_adwords_right.times do |i|
      link = (page.search('#mbEnd').search('ol > li')[i].search('h3>a').length > 0) && page.search('#mbEnd').search('ol > li')[i].search('h3>a').attribute('href').value || ''
      result[:link] = link.split('dest_url%3D')[1] || (link.split('adurl=')[1] && link.split('adurl=')[1].split('%3F')[0]) || link 
      result[:display_url] = (page.search('#mbEnd').search('ol > li')[i].search('cite').length > 0) && page.search('#mbEnd').search('ol > li')[i].search('cite').text || ''
      result[:is_ad] = true
      store_result
    end
  end

  def search_results_google
    @no_of_non_adwords_results =  page.search('li.g').size
    @no_of_non_adwords_results.times do |i|
      result[:link] = (page.search('li.g')[i].search('h3>a').length > 0) && page.search('li.g')[i].search('h3>a').try(:attribute, 'href').try(:value) || ''
      result[:display_url] = (page.search('li.g')[i].search('cite').length > 0) && page.search('li.g')[i].search('cite').text || ''
      result[:is_ad] = false
      store_result
    end
  end

  def store_result
    Result.create(result)
  end
  
  def update_page 
    Page.find(@current_page.id).update_attributes({no_of_adwords_top: @no_of_adwords_top, no_of_adwords_right: @no_of_adwords_right, no_of_non_adwords_results: @no_of_non_adwords_results, total_results_per_page: total_results_per_page, content: content})
  end
  
  def keyword
    @keyword
  end

  def no_of_non_adwords_results
    @no_of_non_adwords_results
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

  def content
    page.content
  end

  def result
    @result
  end

  def total_advertisers
    @no_of_adwords_top + @no_of_adwords_right
  end

end
