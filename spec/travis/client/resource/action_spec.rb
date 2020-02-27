describe Travis::Client::Resource::Action do
  let(:namespace) { factory.define }
  let(:factory) { Travis::Client::Constants::Resources.new(defns) }
  let(:conn)    { double(:conn, endpoint: URI.parse('https://api.travis-ci.com')) }
  let(:defns)   { Travis::Client::Index.new(conn, path: 'spec/fixtures') }
  let(:session) { double('session', request: nil) }
  let(:params)  { {} }
  let(:action)  { namespace[:repository_find].new(session, params)  }

  matcher :have_requested do |method, uri|
    match do |session|
      expect(session).to have_received(:request) do |m, u, _|
        expect(m).to eq method.upcase # block returning a boolean does not work?
        expect(u.to_s).to eq uri
      end
    end
  end

  before { namespace }

  describe 'definition' do
    subject { action }
    it { expect(subject.resource).to eq :repository }
    it { expect(subject.name).to eq :find }
    it { expect(subject.send(:templates).first.to_s).to eq 'GET /repo/{repository.id}{?include}' }
  end

  describe 'call' do
    before { action.call }
    subject { session }

    describe 'given :repository.id' do
      let(:params) { { 'repository.id': 1 } }
      it { should have_requested :get, '/repo/1' }
    end

    describe 'given :repository.slug' do
      let(:params) { { 'repository.slug': 'travis-ci/travis-api' } }
      it { should have_requested :get, '/repo/travis-ci%2Ftravis-api' }
    end
  end
end
