#!/usr/bin/ruby
require 'net/http'
require 'uri'

def get_svg(url)
  Net::HTTP.get(URI.parse(url))
end

%w{
master
}.each_with_index do |branch, i|
  url = "https://app.codeship.com/projects/1e9ecb80-4c2b-0134-ee52-12485c783879/status?branch=#{branch}"
  svg = get_svg(url)
  passing = svg.include?('id="passing"')
  failing = svg.include?('id="failing"')
  running = svg.include?('id="running"')
  queued = svg.include?('id="queued"')
  color = passing ? 'green' : failing ? 'red' : 'white'
  puts "#{i == 0 ? '●' : branch}|color=#{color}"
  if i == 0
    puts '---' if i == 0
    puts "#{branch}|color=#{color}"
  end
end
