#!/opt/local/bin/ruby
require 'Scraper'

class IndeedScraper < Scraper
  
  def initialize search_params
    super
    @base_url = 'http://www.indeed.com/jobs?'
    @param_format = "q=#{@search_params['keyword']}&l=#{@search_params['location']}&sort=#{@search_params['sort_by']}"
    @res_xpath = {
      :row          => "div[@class='row ']",
      :job_url      => "h2/a",
      :job_title    => "h2/a",
      :job_company  => "span[@class='company']",
      :job_location => "span[@class='location']/span"
    }
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