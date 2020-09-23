#! /usr/bin/env ruby
require 'HTTParty'
require 'open-uri'
require 'nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

#requesting the page we're going to scrape
page = HTTParty.get('https://www.indeed.ae/')

#transform http response into a nokogiri object
parse_page = Nokogiri::HTML(page)

#empty array where all jobs from indeed will be stored
pets_array = []

parse_page.css('.content').css('.row').css('.hdrlink').map do |a|
    post_name = a.text
    pets_array.push(post_name)
end

# Pry.start(binding)

CSV.open('pets.csv', 'w') do |csv|
    csv << pets_array
end




# Fetch and parse HTML document
# doc = Nokogiri::HTML(URI.open('https://www.indeed.ae/'))

# css = 'div.jobsearch-SerpJobCard'

# css = 'div.jobsearch-SerpJobCard'

# doc.css(css).each do |title|
# puts css #title.text
# end

# puts "### Search for nodes by css"
# doc.css('nav ul.menu li a', 'article h2').each do |link|
#   puts link.content
# end

# puts "### Search for nodes by xpath"
# doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
#   puts link.content
# end

# puts "### Or mix and match."
# doc.search('nav ul.menu li a', '//article//h2').each do |link|
#   puts link.content
# end


# doc = Nokogiri::HTML(open('https://news.google.com'))

# puts doc.to_s.size

# puts doc.css('div.section-toptop div.esc-wrapper').size

# css = 'div.section-toptop div.esc-wrapper .esc-lead-article-title'

# doc.css(css).each do |title|
#   puts title.text
# end