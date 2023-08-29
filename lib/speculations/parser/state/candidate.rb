module Speculations
  class Parser
    module State
      module Candidate extend self
        def parse line, lnb, node, ctxt, options
          case
          when State.blank_line(line)
            [:candidate, node, ctxt]
          when match = State.context_match(line)
            _parse_context(match, lnb:, node:)
          when match = State.maybe_include(line)
            [:candidate, node, :inc]
          when match = State.maybe_example(line)
            [:candidate, node, match[:title]]
          when match = State.ruby_code_block(line)
            _parse_ruby_code_block(match, ctxt:, lnb:, node:)
          else
            [:out, node]
          end
        end

        private

        def _parse_context(match, lnb:, node:)
          level = match[1].size
          new_parent = node.parent_of_level(level.pred)
          node = new_parent.new_context(title: match[2], lnb: lnb, level: level)
          [:out, node]
        end

        def _parse_ruby_code_block(match, ctxt:, lnb:, node:)
            if ctxt == :inc
              node = node.new_include(lnb: lnb)
            else
              node = node.new_example(title: ctxt, lnb: lnb)
            end
            [:in, node, (ctxt == :inc ? :includes : :out)]
        end


      end
    end
  end
end
#  SPDX-License-Identifier: Apache-2.0
