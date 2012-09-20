#!/opt/local/bin/ruby
require 'scrapers/scraper'

class DiceScraper < Scraper
  
  def initialize search_params
    super
    @base_url = 'http://seeker.dice.com/jobsearch/servlet/JobSearch?Ntx=mode+matchall&FRMT=0&QUICK=1&ZC_COUNTRY=0&SORTSPEC=0&N=0&Hf=0&Ntk=JobSearchRanking&NUM_PER_PAGE=30&op=300&LOCATION_OPTION=2&TAXTERM=0&RADIUS=64.37376&DAYSBACK=30&TRAVEL=0&No=0'
    @param_format = "&FREE_TEXT=#{@search_params['keyword']}&WHERE=#{@search_params['location']}"
  end
  
  def rows doc
    return (doc/"tr.STDsrRes") | (doc/"tr.gold")
  end
  
  def format_result_url row
    return 'seeker.dice.com' + (row/"td/div/a").first['href'].split("@end")[0]
  end
  
  def format_result_title row
    return (row/"td/div").text.strip
  end
  
  def format_result_company row
    return (row/"td[2]").text.strip
  end
  
  def format_result_location row
    return (row/"td[3]").text.strip
  end
  
end