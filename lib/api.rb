require 'httparty'

module TwitterSearch
  class API
	include HTTParty

	base_uri 'search.twitter.com'

	def self.search(query)
	  raise 'query is required' if query.nil? or query.strip.empty?

	  response = self.get('/search.json', { :query => { :q => query, :rpp => 1500 } })
	  response['results'].map do |result|
		{ 
		  :user => result['from_user'], 
		  :text => result['text'],
		  :profile_url => "http://twitter.com/#{result['from_user']}"
		}
	  end
	end
  end
end
