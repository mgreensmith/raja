#!/opt/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Scraper
  attr_accessor :url 
  attr_accessor :base_url 
  attr_accessor :search_params 
  attr_accessor :param_format
  
  def initialize base_url,search_params
    @base_url = base_url
    @search_params = search_params
    @param_format="q=#{@search_params['keyword']}&l=#{@search_params['location']}&sort=#{@search_params['sort_by']}"
    @url = build_url
  end
  
  def build_url
    return "#{@base_url}#{@param_format}"
  end
  
  def scrape
    @results = []
    doc = Nokogiri::HTML(open(@url))
    # jobs are each in a div with class 'row ' (yes, trailing space! #DIAF)
    result_rows = (doc/"div[@class='row ']")  #returns a NodeSet of NodeSets
    result_rows.each do |result_row|
      @results.push(format_result(result_row))
    end
  end
  
  def format_result row
    j_url = 'www.indeed.com' + (row/"h2/a").first['href']
    title = (row/"h2/a").first['title']
    company = (row/"span[@class='company']").text.strip
    location = (row/"span[@class='location']/span").text.strip
      
    result = {   
      :job_url => "#{j_url}",
      :job_title => "#{title}",
      :job_company => "#{company}",
      :job_location => "#{location}",
    }
    return result
  end
  
  def get_results
    scrape
    return @results
  end
  
end


search_params = {
  'keyword'  => 'linux',
  'location' => 'Portland,+Or',
  'sort_by'  => 'date'
}

s = Scraper.new('http://www.indeed.com/jobs?',search_params )
res = s.get_results
puts "Found #{res.length} jobs."
puts res[0][:job_url]
puts res[0][:job_title]
puts res[0][:job_company]
puts res[0][:job_location]