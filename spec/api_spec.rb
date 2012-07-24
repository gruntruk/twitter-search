require 'spec_helper'

describe TwitterSearch::API do
  subject { TwitterSearch::API }

  its(:base_uri) { should == 'http://search.twitter.com' }

  let(:empty_response) { { 'results' => {} } }

  context '.search' do
	it 'should specify the endpoint' do
	  TwitterSearch::API.should_receive(:get).
		with('/search.json', instance_of(Hash)).
		and_return(empty_response)
	  TwitterSearch::API.search 'foobar'
	end

	it 'should specify the query parameter' do
	  TwitterSearch::API.should_receive(:get).
		with(anything, have_a_query_with_key_and_value_of(:q, 'foo')).
		and_return(empty_response)
	  TwitterSearch::API.search 'foo'
	end

	it 'should specify the max results' do
	  TwitterSearch::API.should_receive(:get).
		with(anything, have_a_query_with_key_and_value_of(:rpp, 1500)).
		and_return(empty_response)
	  TwitterSearch::API.search 'foo'
	end

	it 'should transform API results' do
	end

	it 'should raise with nil search argument' do
	  expect { TwitterSearch::API.search(nil) }.to raise_error('query is required')
	end

	it 'should raise with blank search argument' do
	  expect { TwitterSearch::API.search('     ') }.to raise_error('query is required')
	end

  end
end
