module Support
  module Fixtures
    def fixtures_path(*segments)
      @__fixtures_path__ ||= File.join(RSPEC_ROOT, 'fixtures', segments)
    end
  end
end

RSpec.configure do |conf|
  conf.include Support::Fixtures
  conf.extend Support::Fixtures
end
