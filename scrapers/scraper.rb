#!/opt/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Things that must be overloaded to make use of this class:
# @res_xpath, @param_format, @url (must call build_url in the initializer after all vars have been set)
# also, all the 'format_result_' methods need to be specified

class Scraper
  attr_accessor :url 
  attr_accessor :base_url 
  attr_accessor :search_params 
  attr_accessor :param_format
  
  def initialize base_url,search_params
    @res_xpath = {
      :row          => nil,
      :job_url      => nil,
      :job_title    => nil,
      :job_company  => nil,
      :job_location => nil
    }
    @param_format = nil
    @url = nil
    @base_url = base_url
    @search_params = search_params
  end
  
  #these formatters must be overloaded for site-specific classes.
  #========
  def format_result_url row
    return nil
  end
  
  def format_result_title row
    return nil
  end
  
  def format_result_company row
    return nil
  end
  
  def format_result_location row
    return nil
  end
  #========
  
  def build_url
    return "#{@base_url}#{@param_format}"
  end

  def format_result row 
    result = {   
      :job_url      => "#{format_result_url row}",
      :job_title    => "#{format_result_title row}",
      :job_company  => "#{format_result_company row}",
      :job_location => "#{format_result_location row}",
    }
    return result
  end
  
  def scrape
    @results = []
    doc = Nokogiri::HTML(open(@url))
    result_rows = (doc/"#{@res_xpath[:row]}")  #returns a NodeSet of NodeSets
    result_rows.each do |result_row|
      @results.push(format_result(result_row))
    end
  end
  def get_results
    scrape
    return @results
  end
  
end