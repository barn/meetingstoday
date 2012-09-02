#!/usr/bin/env ruby
#

require 'rubygems'
require 'open-uri'
require 'simple-rss'
require 'htmlentities'
require 'awesome_print'

rss = SimpleRSS.parse open 'http://sandperson.tumblr.com/rss'

things = []

rss.items.each do |rssi|
  text = rssi.description

  if text =~ /Beginner.*Advanced/ixm
    real = HTMLEntities.new.decode HTMLEntities.new.decode text
    real.gsub!( '’' , "'" )
    real.gsub!( /[“”]+/ , '"' )

    lines = real.split( "\n" )

    lines.each do |l|
      if l =~ /(Beginner|Advanced|Bonus):<\/strong> \s (".*") <\/p>/ix
        things << $2
      end
    end

  end

end

puts things.choice
