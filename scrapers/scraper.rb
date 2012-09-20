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
  end
  
  def build_url
    return "#{@base_url}#{@param_format}"
  end
  
  def scrape
    @results = []
    doc = Nokogiri::HTML(open(@url))
    result_rows = (doc/"#{@res_xpath[:row]}")  #returns a NodeSet of NodeSets
    result_rows.each do |result_row|
      @results.push(format_result(result_row))
    end
  end
  
  def format_result row
    j_url = format_result_url row
    title = format_result_title row
    company = format_result_company row
    location = format_result_location row
      
    result = {   
      :job_url      => "#{j_url}",
      :job_title    => "#{title}",
      :job_company  => "#{company}",
      :job_location => "#{location}",
    }
    return result
  end
  
  #these formatters are overloaded for site-speific classes.
  def format_result_url row
    return ""
  end
  
  def format_result_title row
    return ""
  end
  
  def format_result_company row
    return ""
  end
  
  def format_result_location row
    return ""
  end
  
  def get_results
    scrape
    return @results
  end
  
end