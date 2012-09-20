#!/opt/local/bin/ruby
require 'scrapers/dicescraper'

search_params = {
  'keyword'  => 'linux',
  'location' => 'Portland,+Or',
  'sort_by'  => 'date'
}

s = DiceScraper.new(search_params )

s.scrape
res = s.results
puts "Found #{res.length} jobs."
puts res[0][:job_url]
puts res[0][:job_title]
puts res[0][:job_company]
puts res[0][:job_location]