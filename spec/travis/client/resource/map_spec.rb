describe Travis::Client::Resource::Params::Map do
  let(:subj)  { Travis::Client::Constants::Params.new(:repository, nil, templ, body).define.new(params) }
  let(:templ) { '/repo/{repository.id}{?include}' }
  let(:body)  { [:one] }

  subject { described_class.new(subj, params).to_h }

  describe 'given nothing' do
    let(:params) { {} }
    it { should be_empty }
  end

  describe 'given id' do
    let(:params) { { id: 1 } }
    it { should eq 'repository.id' => 1 }
  end

  describe 'given repository.id' do
    let(:params) { { 'repository.id': 1 } }
    it { should eq 'repository.id' => 1 }
  end

  describe 'given an entity', init: true do
    let(:repo) { Travis::Client::Repository.new(nil, nil, id: 1, slug: 'travis-ci/travis.rb') }
    let(:params) { { repository: repo } }
    it { should eq 'repository.id' => 1 }
  end

  describe 'given a hash' do
    let(:params) { { repository: { id: 1 } } }
    it { should eq 'repository.id' => 1 }
  end

  describe 'given id and include' do
    let(:params) { { id: 1, include: 'branch' } }
    it { should eq 'repository.id' => 1, 'include' => 'branch' }
  end

  describe 'given id and unknown' do
    let(:params) { { id: 1, unknown: 'unknown' } }
    it { should eq 'repository.id' => 1, 'unknown' => 'unknown' }
  end

  describe 'given id and body param' do
    let(:params) { { id: 1, one: 'one' } }
    it { should eq 'repository.id' => 1, 'one' => 'one' }
  end
end
