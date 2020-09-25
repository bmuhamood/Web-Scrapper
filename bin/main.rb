#!/usr/bin/env ruby
require 'nokogiri'
require 'httparty'
require_relative '../lib/fields.rb'
require_relative '../lib/webscrap.rb'

def check_input(input)
  gets.downcase.chomp.gsub(' ', '%20') if input.nil?
end

def user_inputs
  input = gets.downcase.chomp
  if input.to_i.zero?
    input = input.to_s.gsub(' ', '%20')
  else
    input.to_i
  end
  input
end

def crawling_site(input = nil, query = nil, total = nil, page = 1)
  loop do
    if input.nil?
      input = check_input(input)
    elsif query.to_i.zero?
      input = query.gsub(' ', '%20')
      page = 1
    elsif query.to_i > (total / 20)
      puts 'Page does not exist, wait 3 seconds for reboot.'
      sleep(3)
      page = page
    else
      page = query.to_i
    end
    total = display_results(page, input)
    query = user_inputs
    break if query == 'exit'
  end
end

def display_results(page, input)
  scrape_site = Scraper.new(input, page)
  scrape_site.data
  puts scrape_site.extract_torrent
  total = scrape_site.total_results
  table_object = ScrapedTable.new(page, input, total)
  puts table_object.display_table
  p 'Please EXIT if you want to stop scrapping'
  total
end

crawling_site
