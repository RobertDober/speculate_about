require_relative 'context_maker'
module Speculations
  class Parser
    module State
      module Includes extend self
        include ContextMaker

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

      end
    end
  end
end
