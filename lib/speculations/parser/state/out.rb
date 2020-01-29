module Speculations
  class Parser
    module State
      module Out extend self

        def parse line, lnb, node
          case
          when name = State.context_match(line)
            node = node.parent if node.parent
            new_node = node.add_child(name: name, lnb: lnb)
            [:out, new_node]
          when State.before_match(line)
            node = node.set_setup(lnb: lnb)
            [:bef, node]
          when State.example_match(line)
            node = node.add_example(lnb: lnb)
            [:exa, node]
          when State.include_match(line)
            node = node.add_include(lnb: lnb)
            [:inc, node]
          else
            [:out, node]
          end
        end

      end
    end
  end
end
