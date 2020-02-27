describe Travis::Client::Resource::Error do
  let!(:session) { Travis::Client.init(path: 'spec/fixtures') }
  let(:repo) { session.find_repository(slug: 'unknown') }

  before { stub_request(:get, %r(repo/unknown)).and_return body: fixture('http/not_found') }

  it { expect { repo }.to raise_error Travis::Client::Resource::Error }
end
