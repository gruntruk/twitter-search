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

	it 'should raise with nil search argument' do
	  expect { TwitterSearch::API.search(nil) }.to raise_error('query is required')
	end

	it 'should raise with blank search argument' do
	  expect { TwitterSearch::API.search('     ') }.to raise_error('query is required')
	end

	context 'with search results' do
	  before do
		TwitterSearch::API.should_receive(:get).
		  and_return({ 'results' => [ { 'from_user' => 'user', 'text' => 'tweet' } ] })
		@results = TwitterSearch::API.search('foo')
	  end

	  let(:result) { @results.first }

	  it 'should be an Array' do
		@results.should be_an_instance_of Array
	  end

	  it 'should contain the user' do
		result[:user].should == 'user'
	  end

	  it 'should contain the text' do
		result[:text].should == 'tweet'
	  end

	  it 'should contain the profile_url' do
		result[:profile_url].should == 'http://twitter.com/user'
	  end
	end

  end
end
