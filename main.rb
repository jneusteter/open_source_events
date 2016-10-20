#!/home/john/.rvm/rubies/ruby-2.3.0/bin/ruby

require 'erubis'
require 'sequel'
require 'twitter'

require './var/keys.rb'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

DB = Sequel.connect('sqlite://var/db.sql')

dataset = DB[:events]
$client.mentions_timeline.each do |mention|
  event = Event.new(mention.text)
  puts mention.text
  begin
    if event.delete?
      dataset.filter(id: event.id).delete
      # $client.update("@#{mention.user.screen_name} Event has been deleted", in_reply_to_status_id: mention.id)
    elsif event.id.nil?
      dataset.insert(name: event.name, starts: event.starts, ends: event.ends)
      # $client.update("@#{mention.user.screen_name} Thank you, Event has been created!", in_reply_to_status_id: mention.id)
    else
      record = dataset.filter(id: event.id)
      record.update(name: event.name) unless event.name.nil?
      record.update(starts: event.starts) unless event.starts.nil?
      record.update(ends: event.ends) unless event.ends.nil?
      # $client.update("@#{mention.user.screen_name} Thanks you, Events has been updated.", in_reply_to_status_id: mention.id)
    end
  rescue
    # $client.update("@#{mention.user.screen_name} Please see docs for correct command.", in_reply_to_status_id: mention.id)
  end
end

File.write('web/index.html', Erubis::Eruby.new(File.read('content/index.html')).result(binding))

all_events.each do |event|
  puts event
end
