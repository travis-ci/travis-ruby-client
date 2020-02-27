describe Travis::Client::Resource::Collection do
  let(:session) { Travis::Client.init(path: 'spec/fixtures') }
  let(:repo) { session.find_repository(slug: 'travis-ci%2Ftravis.rb') }
  let(:branches) { session.find_branches(repository: repo, pages: 3) }

  before { stub_request(:get, %r(repo/travis-ci%2Ftravis.rb)).and_return body: fixture('http/repo') }
  before { stub_request(:get, %r(repo/\w+/branches$)).and_return body: fixture('http/repo_branches_0') }
  before { stub_request(:get, %r(repo/\w+/branches\?.*&offset=10)).and_return body: fixture('http/repo_branches_10') }
  before { stub_request(:get, %r(repo/\w+/branches\?.*&offset=20)).and_return body: fixture('http/repo_branches_20') }

  subject { branches.to_a }

  it { expect(subject.size).to eq 22 }
  it { expect(subject.first).to be_a Travis::Client::Resource::Entity }
  it { expect(subject.first.name).to eq 'master' }
end
