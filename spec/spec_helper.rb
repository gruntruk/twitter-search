$:.unshift File.dirname(__FILE__) + '/../lib'

require 'twitter_search'
require 'rspec'

RSpec::Matchers.define :have_a_query_with_key_and_value_of do |expected_key, expected_value|
  match do |actual|
	query = actual[:query]
	query.should_not be_nil
	query[expected_key].should == expected_value
  end
end
