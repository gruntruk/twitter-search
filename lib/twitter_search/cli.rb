require 'twitter_search/api'

module TwitterSearch
  class CLI
	MAX_RESULTS = 25

	def self.search(query, io = STDOUT)
	  results = API.search(query)
	  io.puts "Total Results: #{results.length}"
	  results[0..(MAX_RESULTS - 1)].each do |result|
		io.puts "[#{result[:text]}] #{result[:user]} #{result[:profile_url]}" # single line output
	  end
	end
  end
end
