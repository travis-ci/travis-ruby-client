describe Travis::Client do
  before { stub_request(:get, 'https://api.travis-ci.com').and_return body: fixture('index') }
  before { stub_request(:get, %r(repo/travis-ci%2Ftravis.rb)).and_return body: fixture('http/repo') }

  describe 'init' do
    # shared_examples :constants do
    #   xit { expect(Travis::Client::Error).to be < Travis::Client::Resource::Error }
    #   it { expect(Travis::Client::Repository).to be < Travis::Client::Resource::Entity }
    #   it { expect(Travis::Client::Repositories).to be < Travis::Client::Resource::Collection }
    # end

    describe 'loading the index' do
      before { Travis::Client.init(path: '/tmp/travis-ruby-client') }
      after { FileUtils.rm_rf('/tmp/travis-ruby-client') }
      # include_examples :constants
    end

    describe 'cached index' do
      before { Travis::Client.init(path: 'spec/fixtures') }
      # include_examples :constants
    end
  end

  describe 'global style', init: true do
    subject { Travis::Client::Repository.find(slug: 'travis-ci/travis.rb') }
    it { expect(subject.slug).to eq 'travis-ci/travis.rb' }
  end

  describe 'session style' do
    let(:session) { Travis::Client::Session.new(path: 'spec/fixtures') }
    subject { session.find_repository(slug: 'travis-ci/travis.rb') }
    it { expect(subject.slug).to eq 'travis-ci/travis.rb' }
  end
end
