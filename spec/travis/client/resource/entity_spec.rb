describe Travis::Client::Resource::Entity do
  let(:session) { Travis::Client.init(path: 'spec/fixtures') }
  let(:repo) { session.find_repository(slug: 'travis-ci%2Ftravis.rb') }
  let(:user) { session.find_owner(login: 'rkh') }

  before { stub_request(:get, %r(repo/travis-ci%2Ftravis.rb)).and_return body: fixture('http/repo') }
  before { stub_request(:get, %r(owner/rkh)).and_return body: fixture('http/owner') }
  before { stub_request(:get, %r(user/267\?include=user\.repos)).and_return body: fixture('http/user_repos') }

  describe 'attributes' do
    it { expect(repo.slug).to eq 'travis-ci/travis.rb' }
    it { expect(repo.name).to eq 'travis.rb' }
  end

  describe 'lazy loading' do
    it { expect(user.repositories.first.name).to be == 'almost-sinatra' }
    it { expect(user.repositories.first.owner).to be == user }
  end
end
