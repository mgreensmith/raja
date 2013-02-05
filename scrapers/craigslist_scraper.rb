
require 'scrapers/scraper'

class CraigslistScraper < Scraper
  
  def initialize search_params
    super
    @base_url = 'http://portland.craigslist.org/search/jjj?'
    @param_format = "zoomToPosting=&altView=&query=#{@search_params['keyword']}&srchType=A"
  end
  
  def rows doc
    x = (doc/"blockquote[@id='toc_rows']/p")
    puts x.inspect
    return x
  end
  
  def format_result_url row
    return (row/"a").first['href']
  end
  
  def format_result_title row
    return (row/"a").children.first.text
  end
  
  def format_result_company row
    return ""
  end
  
  def format_result_location row
    return (row/"font").text.strip[1..-2]
  end
  
  
end