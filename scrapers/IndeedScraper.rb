#!/opt/local/bin/ruby
require 'Scraper'

class IndeedScraper < Scraper
  
  def initialize base_url,search_params
    super
    @res_xpath = {
      :row          => "div[@class='row ']",
      :job_url      => "h2/a",
      :job_title    => "h2/a",
      :job_company  => "span[@class='company']",
      :job_location => "span[@class='location']/span"
    }
    @param_format = "q=#{@search_params['keyword']}&l=#{@search_params['location']}&sort=#{@search_params['sort_by']}"
    @url = build_url
  end
  
  def format_result_url row
    return 'www.indeed.com' + (row/"#{@res_xpath[:job_url]}").first['href']
  end
  
  def format_result_title row
    return (row/"#{@res_xpath[:job_title]}").first['title']
  end
  
  def format_result_company row
    return (row/"#{@res_xpath[:job_company]}").text.strip
  end
  
  def format_result_location row
    return (row/"#{@res_xpath[:job_location]}").text.strip
  end
  
  
end