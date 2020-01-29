module Speculations
  class Parser
    module State
      module Inc extend self

        def parse line, _lnb, node
          case
          when State.eoblock_match(line)
            [:out, node.parent]
          else
            [:inc, node.add_line(line)]
          end
        end
      end
    end
  end
end
