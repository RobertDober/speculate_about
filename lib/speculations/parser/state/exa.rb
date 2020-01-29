module Speculations
  class Parser
    module State
      module Exa extend self

        def parse line, _lnb, node
          case
          when State.eoblock_match(line)
            [:out, node.parent]
          else
            [:exa, node.add_line(line)]
          end
        end
      end
    end
  end
end
