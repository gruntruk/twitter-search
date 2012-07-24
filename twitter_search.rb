#! /usr/bin/env ruby
$:.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'twitter_search'

include TwitterSearch

def main
  CLI.search ARGV.first
end

begin
  main
rescue Exception => ex
  STDERR.puts "Error: #{ex.message}"
  exit 1
end
