module Speculations
  class Parser
    class Context
      require_relative './context/include'
      require_relative './context/example'

      DISCLAIMER = <<-EOD
# DO NOT EDIT!!!
# This file was generated from FILENAME with the speculate_about gem, if you modify this file
# one of two bad things will happen
# - your documentation specs are not correct
# - your modifications will be overwritten by the speculate rake task
# YOU HAVE BEEN WARNED
      EOD

      attr_reader :filename, :level, :lnb, :title, :parent, :root, :tree_level

      def new_context(title:, lnb:, level: )
        new_child = self.class.new(title: title, lnb: lnb, parent: self, level: level)
        _realign_levels(new_child)
      end

      def new_example(lnb:, title:)
        examples << Example.new(lnb: lnb, parent: self, title: title)
        examples.last
      end

      def new_include(lnb:)
        includes << Include.new(lnb: lnb, parent: self)
        includes.last
      end

      def parent_of_level needed_min_level
        # I would love to write
        # self.enum_by(:parent).find{ |ctxt| ctxt.level <= needed_min_level }
        current = self
        while current.level > needed_min_level
          current = current.parent
        end
        current
      end

      def children
        @__children__ ||= []
      end

      def examples
        @__examples__ ||= []
      end

      def includes
        @__includes__ ||= []
      end

      def map_lines(*lines, indent: 0)
        prefix = "  " * (tree_level + indent).succ
        lines.flatten.map{ |line| "#{prefix}#{line.strip}" }
      end

      def to_code
        [
          _header,
          includes.map(&:to_code),
          examples.map(&:to_code),
          children.map(&:to_code),
          _footer
        ].flatten.compact
      end

      def with_new_parent new_parent
        @parent = new_parent
        @tree_level += 1
        self
      end


      private

      def initialize(lnb: 0, title: nil, filename: nil, parent: nil, level: 0)
        @filename = filename
        @level    = level
        @lnb      = lnb
        @title    = title
        @parent   = parent
        if parent
          _init_from_parent
        else
          @root = self
          @tree_level  = 0
        end
      end

      def _header
        if parent
          map_lines(%{# #{filename}:#{lnb}}, %{context "#{title}" do}, indent: -1)
        else
          _root_header
        end
      end

      def _root_header
        map_lines(DISCLAIMER.gsub("FILENAME", filename.inspect).split("\n"), %{RSpec.describe #{filename.inspect} do}, indent: -1)
      end

      def _init_from_parent
        @root = parent.root
        @filename = parent.filename
        @tree_level = parent.tree_level.succ
      end

      def _footer
        map_lines("end", indent: -1)
      end

      def _realign_levels new_parent
        if children.empty? || children.first.level == new_parent.level
          children << new_parent
          return new_parent
        end
        children.each do |child|
          new_parent.children << child.with_new_parent(new_parent)
        end
        @__children__ = [new_parent]
        new_parent
      end

    end
  end
end
