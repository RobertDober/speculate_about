require 'securerandom'
module Support
  module Naming
    INITIALS = [*'A'..'Z']

    def any_name length: 10, to_sym: false
      (INITIALS.sample +
       SecureRandom.alphanumeric(length-1)).tap do |name|
        return name.to_sym if to_sym
      end
    end

    def any_names count: 42, length: 10, to_sym: false, &block
      (1..count).map{ any_name(length: length, to_sym: to_sym) }.each(&block)
    end
  end
end
RSpec.configure do |conf|
  conf.include Support::Naming
end
