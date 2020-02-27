describe Travis::Client::Index do
  let(:conn) { double(:conn, endpoint: URI.parse('https://api.travis-ci.com')) }
  let(:path) { 'spec/fixtures' }

  subject { described_class.new(conn, path: path) }

  it { expect(subject.resources[:account][:@type]).to eq 'resource' }
  it { expect(subject.errors[:not_found][:status]).to eq 404 }
end
