module Speculations
  class Parser
    module State
      module Out extend self

        def parse line, lnb, node
          if node.alternate_syntax
            _parse_alternate line, lnb, node
          else
            _parse_classical line, lnb, node
          end
        end

        private

        def _parse_alternate line, lnb, node
          case
          when name = State.context_match(line)
            node = node.parent if node.parent
            new_node = node.add_child(name: name, lnb: lnb)
            new_node.set_name(nil)
            [:out, new_node]
          when State.ws_match(line)
            [:out, node]
          when name = State.potential_name(line)
            node.set_name(name[1])
            [:out, node]
          when State.ruby_match(line)
            if node.potential_name
              node = node.add_example(lnb: lnb, line: line)
              [:exa, node]
            else
              node = node.add_include(lnb: lnb)
              [:inc, node]
            end
          else
            node.set_name(nil)
            [:out, node]
          end
        end

        def _parse_classical line, lnb, node
          case
          when name = State.context_match(line)
            node = node.parent if node.parent
            new_node = node.add_child(name: name, lnb: lnb)
            [:out, new_node]
          when State.before_match(line)
            node = node.set_setup(lnb: lnb)
            [:bef, node]
          when State.example_match(line)
            node = node.add_example(lnb: lnb, line: line)
            [:exa, node]
          when State.include_match(line)
            node = node.add_include(lnb: lnb)
            [:inc, node]
          when name = State.potential_name(line)
            node.set_name(name[1])
            [:out, node]
          else
            [:out, node]
          end
        end

      end
    end
  end
end
