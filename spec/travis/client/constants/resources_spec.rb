describe Travis::Client::Constants::Resources do
  let(:consts) { described_class.new(defns) }
  let(:ctx) { double(:ctx, endpoint: URI.parse('https://api.travis-ci.com')) }
  let(:defns) { Travis::Client::Index.new(ctx, path: 'spec/fixtures') }
  let(:namespace) { consts.define }

  before { namespace }

  matcher :have_attr do |name|
    match do |const|
      const.method_defined?(name) && const.method_defined?("#{name}?")
    end
  end

  matcher :have_action do |name|
    match do |const|
      const.method_defined?(name)
    end
  end

  describe 'Resources::Repository' do
    subject { namespace[:repository] }

    it { should have_attr :name }
    it { should have_attr :slug }
    it { should have_attr :private }

    it { should have_action :find }
  end

  describe 'Session' do
    subject { Travis::Client::Session }

    it { should have_action :repository_find }
    it { should have_action :find_repository }
  end
end
