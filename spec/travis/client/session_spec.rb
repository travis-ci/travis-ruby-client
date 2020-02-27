describe Travis::Client::Session do
  let(:json) { File.read('spec/fixtures/http/repo.json') }
  let(:session) { described_class.new(path: 'spec/fixtures', endpoint: endpoint) }
  let(:endpoint) { 'https://api.travis-ci.com' }
  let(:path) { '/repo/409371' }
  let(:url)  { [endpoint, path].join }

  subject { session.request(:GET, path) }

  before { stub_request(:get, url).and_return(body: json) }

  it { expect(subject.href.to_s).to eq url }
  it { expect(subject.slug).to eq 'travis-ci/travis.rb' }
end
