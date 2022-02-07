# frozen_string_literal: true

module Speculations
  class Parser
    module State
      module ContextMaker
        private

        def make_new_context(lnb:, match:, node:)
          level = match[:level].size
          new_parent = node.parent_of_level(level.pred)
          node = new_parent.new_context(title: match[:title], lnb:, level:)
          [:out, node]
        end
      end
    end
  end
end
