module Support
  module Fixtures
    def fixtures_path(*segments)
      File.join('spec', 'fixtures', segments)
    end
  end
end

RSpec.configure do |conf|
  conf.include Support::Fixtures
  conf.extend Support::Fixtures
end
