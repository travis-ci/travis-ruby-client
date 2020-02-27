module Support
  module Fixtures
    def fixture(key)
      File.read("spec/fixtures/#{key}.json")
    end

    def parse(str)
      symbolize(JSON.parse(str))
    end
  end
end
