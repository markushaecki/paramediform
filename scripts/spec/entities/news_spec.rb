require File.dirname(__FILE__) + '/../../lib/entities/news.rb'

describe 'News' do

  let(:fetch_response) { [
    { '_id'           => 'someid',
      '_label'        => 'Hello world',
      '_slug'         => 'hello-world',
      'interview'     => '42',
      'published_at'  => '05.10.2014',
      '_visible'      => 'true'
    }
  ] }
  let(:api) { instance_double('API', fetch: fetch_response) }

  before { News.api = api }

  describe '.untweeted' do

    subject { News.untweeted }

    it { expect(subject.size).to eq 1 }
    it { expect(subject.first._id).to eq 'someid' }
    it { expect(subject.first.title).to eq 'Hello world' }
    it { expect(subject.first.slug).to eq 'hello-world' }
    it { expect(subject.first.type).to eq 'interview' }

  end

  describe '#post!' do

    let(:news) { News.new('someid', 'Hello world') }
    let(:twitter_client) { double('Twitter') }

    before { news.url = 'http://www.google.com' }

    it do
      expect(twitter_client).to receive(:update).with("Hello world http://www.google.com")
      expect(api).to receive(:update).with('content_types/news/entries', 'someid', { tweeted: true })
      news.post!(twitter_client)
    end

  end

end
