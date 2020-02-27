describe Travis::Client::Resource::Params do
  let(:const)  { Travis::Client::Constants::Params.new(:repository, method, templ, body).define }
  let(:method) { 'GET' }
  let(:templ)  { '/repo/{repository.id}{?include}' }
  let(:body)   { [:one] }

  describe 'accept?' do
    subject { const.new(params).accept? }

    describe 'given nothing' do
      let(:params) { {} }
      it { should be false }
    end

    describe 'given id' do
      let(:params) { { id: 1 } }
      it { should be true }
    end

    describe 'given repository.id' do
      let(:params) { { 'repository.id': 1 } }
      it { should be true }
    end

    describe 'given an entity', init: true do
      let(:repo) { Travis::Client::Repository.new(nil, nil, id: 1, slug: 'travis-ci/travis.rb') }
      let(:params) { { repository: repo } }
      it { should be true }
    end

    describe 'given id and include' do
      let(:params) { { id: 1, include: 'branch' } }
      it { should be true }
    end

    describe 'given id and unknown (GET)' do
      let(:params) { { id: 1, unknown: 'unknown' } }
      it { should be false }
    end

    describe 'given id and unknown (POST, empty body)' do
      let(:method) { 'POST' }
      let(:body)   { [] }
      let(:params) { { id: 1, unknown: 'unknown' } }
      it { should be true }
    end

    describe 'given id and unknown (POST, non-empty body)' do
      let(:method) { 'POST' }
      let(:params) { { id: 1, unknown: 'unknown' } }
      it { should be false }
    end

    describe 'given id and body param' do
      let(:params) { { id: 1, one: 'one' } }
      it { should be true }
    end
  end

  describe 'possible_params' do
    subject { const.new({}).possible_params }
    it { should eq ':id, optionally :include, :one' }
  end
end
