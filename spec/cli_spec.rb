require 'spec_helper'

describe TwitterSearch::CLI do
  context '.search' do
	let(:io) { stub(:puts => '') }

	let(:results) { (1..30).inject([]) { |v| v << {} } }

	it 'should delegate to API' do
	  TwitterSearch::API.should_receive(:search).with('query').and_return([])
	  TwitterSearch::CLI.search 'query'
	end

	it 'should print the results count' do
	  TwitterSearch::API.should_receive(:search).and_return([ {} ])
	  io.should_receive(:puts).with('Total Results: 1')
	  TwitterSearch::CLI.search 'query', io
	end
	
	it 'should print the results' do
	  result = { :text => 'test', :user => 'user', :profile_url => 'http://twitter.com/user' }
	  TwitterSearch::API.should_receive(:search).and_return([ result ])
	  io.should_receive(:puts).with('[test] user http://twitter.com/user')
	  TwitterSearch::CLI.search 'test', io
	end

	it 'should display no more than 25 results' do
	  TwitterSearch::API.should_receive(:search).and_return(results)
	  io.should_receive(:puts).exactly(26).times
	  TwitterSearch::CLI.search 'test', io
	end
  end
end
