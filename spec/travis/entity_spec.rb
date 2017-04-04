describe Travis::Client::Entity do
  let(:session) { Travis::Client::Connection.new(http_factory: Support::FakeHTTP.new).create_session }
  subject(:user) { session.find_owner(login: 'rkh') }

  describe :inspect do
    example { expect(user.inspect).to include('/user/267') }
  end

  describe :to_h do
    let(:json) { session.connection.http_factory.request('GET', 'https://api.travis-ci.org/owner/rkh').body }
    example { expect(user.to_h).to be == JSON.load(json) }
  end

  describe :to_entity do
    example { expect(user.to_entity).to be == user }
  end

  describe :permission do
    example { expect(user).to     be_permission(:read) }
    example { expect(user).not_to be_permission(:sync) }
  end

  describe 'lazy loading' do
    example { expect(user.repositories.first.name)  .to be == 'almost-sinatra' }
    example { expect(user.repositories.first.owner) .to be == user }
  end
end
