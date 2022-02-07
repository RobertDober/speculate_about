# frozen_string_literal: true

module Speculations
  class Parser
    module State
      module Candidate extend self
        def parse(line, lnb, node, ctxt)
          case
          when State.blank_line(line)
            [:candidate, node, ctxt]
          when match = State.context_match(line)
            _parse_context(match, lnb:, node:)
          when State.maybe_include(line)
            [:candidate, node, :inc]
          when match = State.maybe_example(line)
            [:candidate, node, match[:title]]
          when State.ruby_code_block(line)
            _parse_ruby_code_block(ctxt:, lnb:, node:)
          else
            [:out, node]
          end
        end

        private

        def _parse_context(match, lnb:, node:)
          level = match[1].size
          new_parent = node.parent_of_level(level.pred)
          node = new_parent.new_context(title: match[2], lnb:, level:)
          [:out, node]
        end

        def _parse_ruby_code_block(ctxt:, lnb:, node:)
          node = if ctxt == :inc
                   node.new_include(lnb:)
                 else
                   node.new_example(title: ctxt, lnb:)
                 end
            [:in, node, (ctxt == :inc ? :includes : :out)]
        end
      end
    end
  end
end
#  SPDX-License-Identifier: Apache-2.0
