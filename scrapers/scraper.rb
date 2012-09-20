#!/opt/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Things that must be overloaded to make use of this class:
# instance vars: @base_url, @param_format
# methods: rows, format_result_url, format_result_title, format_result_company, format_result_location

class Scraper
  attr_accessor :search_params
  attr_accessor :results
  
  def initialize search_params
    @param_format = nil
    @base_url = nil
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
    rows(doc).each do |result_row|
      @results.push(format_result(result_row))
    end
  end
  
end