#!/home/john/.rvm/rubies/ruby-2.3.0/bin/ruby

require 'twitter'
require 'yaml'

require './keys.rb'

@events = []
$client.mentions_timeline.each do |tweet|
  @events << tweet.text
end

File.write('events.yml', @events.to_yaml)

class Event
  def initialize(command)
    @command = command
  end

  def array
    @command.gsub(' -', '-').split('-')
  end

  def add?
    array.include?('add')
  end

  def name
    name = array.select { |name| name[0..3] == 'name' }[0]
    if name.nil?
      # nothing
    else
      name.gsub('name ', '')
    end
  end

  def starts
    starts = array.select { |starts| starts[0..5] == 'starts' }[0]
    if starts.nil?
      # nothing
    else
      Date.parse(starts.gsub('starts ', ''))
    end
  end

  def ends
    ends = array.select { |ends| ends[0..3] == 'ends' }[0]
    if ends.nil?
      # nothing
    else
      Date.parse(ends.gsub('ends', ''))
    end
  end
end
