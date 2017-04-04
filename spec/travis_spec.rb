describe Travis do
  describe 'generated constants' do
    before(:all) { Travis.connect(http_factory: Support::FakeHTTP.new) }
    before { @stderr, $stderr = $stderr, StringIO.new }
    after { $stderr = @stderr }

    example { expect(Travis::Owner.find(login: 'rkh')).to be == Travis.session.find_user(id: 267, include: 'user.repositories') }
    example { expect { Travis::Owner.find(login: 'rkh').sync }.to raise_exception(Travis::LoginRequired) }
    example { expect { Travis::Missing }.to raise_exception(NameError) }
    example { expect(Travis::Repository.find(slug: 'travis-ci/travis.rb').find_branches) .to be == Travis.session.branches_find('repository.id' => 409371) }
    example { expect(Travis::Repository.find(slug: 'travis-ci/travis.rb').branches)      .to be == Travis.session.branches_find('repository.id' => 409371) }

    example do
      Travis.connect(http_factory: Support::FakeHTTP.new)
      expect($stderr.string).to include('WARNING: It is not recommended to call Travis.connect more than once')
    end
  end
end
