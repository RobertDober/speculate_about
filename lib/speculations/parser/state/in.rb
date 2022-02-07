# frozen_string_literal: true

module Speculations
  class Parser
    module State
      module In extend self
        def parse(line, _lnb, node, ctxt)
          case
          when State.eoblock_match(line)
            [ctxt, node.parent]
          else
            [:in, node.add_line(line), ctxt]
          end
        end
      end
    end
  end
end
