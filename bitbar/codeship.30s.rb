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
  passing = svg.include?('id="passing"')
  failing = svg.include?('id="failing"')
  running = svg.include?('id="running"')
  color = passing ? 'green' : running ? 'white' : 'red'
  puts "#{i == 0 ? '●' : branch}|color=#{color}"
  if i == 0
    puts '---' if i == 0
    puts "#{branch}|color=#{color}"
  end
end
