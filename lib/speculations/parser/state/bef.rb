module Speculations
  class Parser
    module State
      module Bef extend self

        def parse line, _lnb, node
          case
          when State.eoblock_match(line)
            [:out, node.parent]
          else
            [:bef, node.add_line(line)]
          end
        end
      end
    end
  end
end
