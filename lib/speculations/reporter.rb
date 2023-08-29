# frozen_string_literal: true

module Speculations
  module Reporter
    def say(string, options, indent: 0, indent_length: 2, underline: nil)
      return unless options.verbose
      prefix = ' ' * indent * indent_length
      $stderr.puts(prefix + string)
      if underline
        $stderr.puts(prefix + string.gsub(/./, underline))
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
