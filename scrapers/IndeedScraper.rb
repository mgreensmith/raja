#!/opt/local/bin/ruby
require 'scrapers/scraper'

class IndeedScraper < Scraper
  
  def initialize search_params
    super
    @base_url = 'http://www.indeed.com/jobs?'
    @param_format = "q=#{@search_params['keyword']}&l=#{@search_params['location']}&sort=#{@search_params['sort_by']}"
  end
  
  def rows doc
    return (doc/"div[@class='row ']")
  end
  
  def format_result_url row
    return 'www.indeed.com' + (row/"h2/a").first['href']
  end
  
  def format_result_title row
    return (row/"h2/a").first['title']
  end
  
  def format_result_company row
    return (row/"span[@class='company']").text.strip
  end
  
  def format_result_location row
    return (row/"span[@class='location']/span").text.strip
  end
  
end