require File.dirname(__FILE__) + '/../../lib/entities/institute.rb'

describe 'Institute' do

  let(:fetch_response) { [{ 'name' => 'Basel', 'url' => 'http://www.example.com', '_slug' => 'basel' }] }
  let(:api) { instance_double('API', fetch: fetch_response) }

  before { Institute.api = api }

  describe '.all' do

    subject { Institute.all }

    it { expect(subject.size).to eq 1 }
    it { expect(subject.first.name).to eq 'Basel' }
    it { expect(subject.first.url).to eq 'http://www.example.com' }
    it { expect(subject.first.slug).to eq 'basel' }

  end

end
