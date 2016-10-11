#!/home/john/.rvm/rubies/ruby-2.3.0/bin/ruby

require 'twitter'
require 'yaml'

require './keys.rb'

@events = []
$client.mentions_timeline.each do |tweet|
  @events << tweet.text
end

File.write('events.yml', @events.to_yaml)
