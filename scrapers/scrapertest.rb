#!/opt/local/bin/ruby
require 'IndeedScraper'

search_params = {
  'keyword'  => 'linux',
  'location' => 'Portland,+Or',
  'sort_by'  => 'date'
}

s = IndeedScraper.new('http://www.indeed.com/jobs?',search_params )

#puts s.scrape
res = s.get_results
puts "Found #{res.length} jobs."
puts res[0][:job_url]
puts res[0][:job_title]
puts res[0][:job_company]
puts res[0][:job_location]