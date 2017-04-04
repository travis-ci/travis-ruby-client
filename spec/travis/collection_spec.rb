describe Travis::Client::Collection do
  let(:session)      { Travis::Client::Connection.new(http_factory: Support::FakeHTTP.new).create_session }
  let(:repository)   { session.find_repository(slug: 'travis-ci/travis.rb') }
  subject(:branches) { session.find_branches(repository: repository, limit: 10) }

  example { expect(branches.size).to be == 22 }
  example { expect(branches.to_a.size).to be == 22 }

  example { expect(branches).to     be_first_page }
  example { expect(branches).not_to be_last_page  }

  example { expect(branches.last_page.first_page).to be == branches }
  example { expect(branches.pagination_info['first'].fetch)     .to be == branches                            }
  example { expect(branches.pagination_info['first'].to_entity) .to be == branches                            }
  example { expect(branches.pagination_info['first'].offset)    .to be == 0                                   }
  example { expect(branches.pagination_info['first'].limit)     .to be == 10                                  }
  example { expect(branches.pagination_info['first'].inspect)   .to include('/repo/409371/branches?limit=10') }
  example { expect(branches.pagination_info['first'].to_h)      .to include('@href')                          }
end
