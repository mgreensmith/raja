#!/opt/local/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://seeker.dice.com/jobsearch/servlet/JobSearch?op=300&N=0&Hf=0&NUM_PER_PAGE=30&Ntk=JobSearchRanking&Ntx=mode+matchall&AREA_CODES=&AC_COUNTRY=1525&QUICK=1&ZIPCODE=&RADIUS=64.37376&ZC_COUNTRY=0&COUNTRY=1525&STAT_PROV=0&METRO_AREA=33.78715899%2C-84.39164034&TRAVEL=0&TAXTERM=0&SORTSPEC=0&FRMT=0&DAYSBACK=30&LOCATION_OPTION=2&FREE_TEXT=linux&WHERE=portland+or"))

# all job rows are class 'STDsrRes' or 'gold'
job_rows = (doc/"tr.STDsrRes") | (doc/"tr.gold")

job_rows.each do |row|
    # row structure looks like:
    # <td> 
    #   <div>
    #     <a href=[relative job link]>[job title]</a>
    #   </div>
    # </td>
    # <td>
    #   <a href=[relative company link]>[company name]</a>
    # </td>
    # <td>
    #   [job location]
    # </td>
    # <td>
    #   [job posting date (often a repost)]
    # </td>
    
    # typical job url looks like:
    # /jobsearch/servlet/JobSearch?op=302&dockey=xml/1/e/1e9abfb2d56474e920d2ecd3a9615016@endecaindex&source=19&FREE_TEXT=linux&rating=99
    # everything from "@endecaindex..." onwards doesn't seem to be required, so we strip it. we also add the domain to make an absolute link.
    
    job_url = 'seeker.dice.com' + (row/"td/div/a").first['href'].split("@end")[0]
    job_title = (row/"td/div").text.strip
    job_company = (row/"td[2]").text.strip
    job_location = (row/"td[3]").text.strip
    puts "#{job_title}\n#{job_company}\n#{job_location}\n\n"
end