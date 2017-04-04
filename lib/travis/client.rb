# frozen_string_literal: true
require 'addressable/uri'
require 'addressable/template'
require 'http'
require 'json'

module Travis
  module Client
    require 'travis/client/version'

    require 'travis/client/action'
    require 'travis/client/connection'
    require 'travis/client/context'
    require 'travis/client/entity'
    require 'travis/client/error'
    require 'travis/client/link'
    require 'travis/client/session'

    require 'travis/client/collection'
    require 'travis/client/unknown'
  end

  extend Client::Context
  self.default_endpoint = 'https://api.travis-ci.org'
end
