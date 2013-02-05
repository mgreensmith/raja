
require '../scrapers/silicon_forest_scraper'

search_params = {
  'keyword'  => '',
  'location' => '',
  'sort_by'  => ''
}

s = SiliconFloristScraper.new(search_params )

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