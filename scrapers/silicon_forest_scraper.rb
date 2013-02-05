
require 'scrapers/scraper'

class SiliconFloristScraper < Scraper
  
  def initialize search_params
    super
    @base_url = 'http://siliconflorist.com/jobs/'
    @param_format = "" # no filters possible for SF
  end
  
  def rows doc
    return (doc/"table[@id='wpjb_jobboard']/tbody/tr")
  end
  
  def format_result_url row
    return (row/"td[2]/a").first['href']
  end
  
  def format_result_title row
    return (row/"td[2]/a").text
  end
  
  def format_result_company row
    return (row/"td[2]").children.last.to_s.strip
  end
  
  def format_result_location row
    return (row/"td[4]").text.strip
  end
  
end