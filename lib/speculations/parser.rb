# frozen_string_literal: true

module Speculations
  class Parser
    require_relative './parser/context'
    require_relative './parser/state'

    def self.parsers
      @__parsers__ ||= {
        candidate: State::Candidate,
        in: State::In,
        includes: State::Includes,
        out: State::Out
      }
    end

    def parse_from_file(file)
      @filename = file
      @input = File
               .new(file)
               .each_line(chomp: true)
               .lazy
      parse!
    end

    private

    def initialize
      @state = :out
    end

    def parse!
      root = node = Context.new(filename: @filename)
      ctxt = nil
      @input.each_with_index do |line, lnb|
        parser = self.class.parsers.fetch(@state)
        @state, node, ctxt = parser.parse(line, lnb.succ, node, ctxt)
      end
      root
    end
  end
end
