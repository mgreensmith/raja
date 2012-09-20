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
  end
  
  def format_result
  end
  
  def assemble_results
  end
end


search_params = {
  'keyword'  => 'linux',
  'location' => 'Portland,+Or',
  'sort_by'  => 'date'
}

s = Scraper.new('http://www.indeed.com/jobs?',search_params )
puts s.build_url