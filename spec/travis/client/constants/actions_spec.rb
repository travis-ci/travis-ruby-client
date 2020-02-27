describe Travis::Client::Constants::Actions do
  let(:namespace) { Module.new { include Registry } }
  let(:templs) { [request_method: 'GET', uri_template: '/repo/{repository.id}{?include}'] }
  let(:consts) { described_class.new(namespace, :repository, :find, templs) }

  before { consts.define }

  matcher :have_definition do |name, value = nil|
    match do |const|
      value ? const.definition[name] == value : const.definition.respond_to?(name)
    end
  end

  subject { namespace[:find_repository] }

  it { should have_definition :resource, :repository }
  it { should have_definition :name, :find }
  it { should have_definition :templates }
end
