#!/opt/local/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=linux&l=Portland%2C+OR"))

# jobs are each in a div with class 'row ' (yes, trailing space! #DIAF)
job_rows = (doc/"div[@class='row ']")  

job_rows.each do |row|
    # row structure looks like:
    # <div>
    #   <h2 class=jobtitle>
    #     <a href=[job url] title=[job title]</a>
    #   </h2>
    #   <span class=company>[company name}</span>
    #   <span><span><span>[job location]</span></span></span>
    #   ...[snip]...
    # </div>
    
    # typical job url looks like:
    # /rc/clk?jk=381744c7cc0f86b6
    # just need to add the domain to make an absolute link.
    job_url = 'www.indeed.com' + (row/"h2/a").first['href']
    job_title = (row/"h2/a").first['title']
    job_company = (row/"span[@class='company']").text.strip
    job_location = (row/"span[@class='location']/span").text.strip
    puts "#{job_title}\n#{job_company}\n#{job_location}\n\n"
end