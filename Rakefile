
require 'scrapers/indeed_scraper'
require 'scrapers/dice_scraper'
require 'scrapers/silicon_florist_scraper'
require 'scrapers/craigslist_scraper'

def results s
  s.scrape
  res = s.results
  puts "Found #{res.length} jobs."
  res.each do |r|
      puts r[:job_url]
      puts r[:job_title]
      puts r[:job_company]
      puts r[:job_location]
      puts "\n"
  end
end

task :indeed do
  search_params = {
    'keyword'  => 'linux',
    'location' => 'Portland,+Or',
    'sort_by'  => 'date'
  }
  results(IndeedScraper.new(search_params))
end

task :dice do
  search_params = {
    'keyword'  => 'linux',
    'location' => 'Portland,+Or',
    'sort_by'  => 'date'
  }
  results(DiceScraper.new(search_params))
end

task :sf do
  search_params = {
    'keyword'  => '',
    'location' => '',
    'sort_by'  => ''
  }
  results(SiliconFloristScraper.new(search_params))
end

task :cl do
  search_params = {
    'keyword'  => 'linux',
    'location' => '',
    'sort_by'  => ''
  }
  results(CraigslistScraper.new(search_params))
end