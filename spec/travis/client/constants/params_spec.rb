describe Travis::Client::Constants::Params do
  let(:consts) { described_class.new(:repository, :GET, templ, body) }
  let(:templ) { '/repo/{repository.id}{?include}' }
  let(:body) { [:one] }

  subject { consts.define }

  matcher :have_definition do |name, value = nil|
    match do |const|
      value ? const.definition[name] == value : const.definition.respond_to?(name)
    end
  end

  it { should have_definition :resource, :repository }
  it { should have_definition :method, :GET }
  it { should have_definition :required, ['repository.id'] }
  it { should have_definition :optional, ['include'] }
  it { should have_definition :body, [:one] }
end
