module Speculations
  class Parser
    module State
      module Includes extend self

        def parse line, lnb, node, _ctxt
          case
          when match = State.context_match(line)
            make_new_context(lnb: lnb, node: node, match: match)
          when match = State.maybe_include(line)
            [:candidate, node, :inc]
          when match = State.maybe_example(line)
            [:candidate, node, match[:title]]
          else
            [:includes, node]
          end
        end

        private

        def make_new_context(lnb:, match:, node:)
          level = match[:level].size
          new_parent = node.parent_of_level(level.pred)
          node = new_parent.new_context(title: match[:title], lnb: lnb, level: level)
          [:out, node]
        end

      end
    end
  end
end
