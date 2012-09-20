#!/opt/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Things that must be overloaded to make use of this class:
# Instance vars: @res_xpath, @param_format,
# methods: format_result_url, format_result_title, format_result_company, format_result_location

class Scraper
  attr_accessor :search_params
  attr_accessor :results
  
  def initialize base_url,search_params
    @res_xpath = {
      :row          => nil,
      :job_url      => nil,
      :job_title    => nil,
      :job_company  => nil,
      :job_location => nil
    }
    @param_format = nil
    @base_url = base_url
    @search_params = search_params
  end
  
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
    doc = Nokogiri::HTML(open(build_url))
    (doc/"#{@res_xpath[:row]}").each do |result_row|
      @results.push(format_result(result_row))
    end
  end
  
end