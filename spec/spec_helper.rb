require 'support/fixtures'
require 'travis/client'
require 'webmock/rspec'

RSpec.configure do |c|
  c.include include Support::Fixtures
  c.include include Travis::Client::Helper::String
  c.include include Travis::Client::Helper::Hash
  c.before(:each, init: true) { Travis::Client.init(path: 'spec/fixtures') }
  # c.after { Travis::Client.reset }

  c.after do
    const = Travis::Client::Resources
    const.constants.map { |name| const.send(:remove_const, name) }
  end
end
