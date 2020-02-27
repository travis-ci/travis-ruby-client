describe Travis::Client::Constants::Templates do
  let(:consts) { described_class.new(:repository, templs) }
  let(:templs) { [request_method: 'GET', uri_template: '/repo/{repository.id}{?include}'] }

  subject { consts.define.first }

  matcher :have_definition do |name, value = nil|
    match do |const|
      value ? const.definition[name] == value : const.definition.respond_to?(name)
    end
  end

  it { should have_definition :resource, :repository }
  it { should have_definition :method, :GET }
  it { should have_definition :required, ['repository.id'] }
  it { should have_definition :optional, ['include'] }
  it { should have_definition :params }
end
