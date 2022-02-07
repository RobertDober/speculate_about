# frozen_string_literal: true

require_relative 'context_maker'
module Speculations
  class Parser
    module State
      module Out extend self
        include ContextMaker

        def parse(line, lnb, node, _ctxt)
          case
          when match = State.context_match(line)
            make_new_context(lnb:, node:, match:)
          when match = State.maybe_example(line)
            [:candidate, node, match[:title]]
          when State.maybe_include(line)
            [:candidate, node, :inc]
          else
            [:out, node]
          end
        end
      end
    end
  end
end
