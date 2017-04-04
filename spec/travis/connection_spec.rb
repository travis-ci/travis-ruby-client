describe Travis::Client::Connection do
  subject(:connection) { Travis::Client::Connection.new(http_factory: Support::FakeHTTP.new) }

  describe :resource_types do
    example { expect(connection.resource_types).to include('repository') }
    example { expect(connection.resource_types[ 'repository'   ].superclass).to be == Travis::Client::Entity     }
    example { expect(connection.resource_types[ 'repositories' ].superclass).to be == Travis::Client::Collection }
  end

  [:before_request, :after_request].each do |callback_type|
    describe callback_type do
      let(:requests) { [] }
      before { connection.public_send(callback_type) { |request| requests << request } }
      example do
        connection.create_session.request('GET', 'https://api.travis-ci.org')
        expect(requests.first.uri.to_s).to be == 'https://api.travis-ci.org'
      end
    end
  end

  describe :action do
    example { expect(connection.action(:user, :find)).to be_a(Travis::Client::Action) }
    example { expect { connection.action(:foo,  :bar) }.to raise_exception(ArgumentError) }
    example { expect { connection.action(:user, :bar) }.to raise_exception(ArgumentError) }
  end
end
