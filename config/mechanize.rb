require 'mechanize'

mecahnize = Mechanize.new
mecahnize.user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2'

def rhs_block_ads
  page.search('#mbEnd').search('ol > li')
  no_of_adwords_right =  page.search('#mbEnd').search('ol > li').size
  no_of_adwords_right.times do |i|
    link = page.search('#mbEnd').search('ol > li')[i].search('h3>a').attribute('href').value.split('ad_url=')[1]
  end
end

def search_results_google
  page.search('li.g')
  no_of_non_adwords_results =  page.search('li.g').size
  no_of_non_adwords_results.times do |i|
    link = page.search('li.g')[i].search('h3>a').attribute('href').value
  end
end

def top_ads
  page.search('#tads').search('ol>li')
  no_of_adwords_top = page.search('#tads').search('ol>li').size
  no_of_adwords_top.times do |i|
    link =  page.search('#tads').search('ol>li')[i].search('h3>a').attribute('href').value.split('dest_url%3D')[1]
    display_url = page.search('#tads').search('ol>li')[i].search('cite').text
  end
end

def total_results_per_page
  total_advertisers + no_of_non_adwords_results
end

start = 0
keyword = 'hair dryer'
def get_page
  page =  mechanize.get('http://www.google.com/search?gcx=w&sourceid=chrome&ie=UTF-8&start='+start+'&q='+ keyword.gsub(" ", "+") )
end

def content
  page.content
end

def total_advertisers
  no_of_adwords_top + no_of_adwords_right
end

loop do
  get_page
  top_ads
  rhs_block
  search_results_google
  break if no_of_search_results < 11
  start += 10
end
