#!/usr/bin/ruby
require 'net/http'
require 'uri'

def open(url)
    Net::HTTP.get(URI.parse(url))
end

%w{
create-weekend-discovery-product
master
}.each_with_index do |branch, i|
  url = "https://app.codeship.com/projects/1e9ecb80-4c2b-0134-ee52-12485c783879/status?branch=#{branch}"
  svg = open(url)
  puts "#{i == 0 ? '●' : branch}|color=#{svg.include?('id="passing"') ? 'green' : 'red'}"
  if i == 0
    puts '---' if i == 0
    puts "#{branch}|color=#{svg.include?('id="passing"') ? 'green' : 'red'}"
  end
end
