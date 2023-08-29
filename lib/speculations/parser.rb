module Speculations
  class Parser
    require_relative './parser/context'
    require_relative 'reporter'
    require_relative './parser/state'

    include Reporter

    def self.parsers
      @__parsers__ ||= {
        candidate: State::Candidate,
        in: State::In,
        includes: State::Includes,
        out: State::Out
      }
    end

    def parse_from_file file, options
      @filename = file
      @input = File
        .new(file)
        .each_line(chomp: true)
        .lazy
      parse!(options)
    end

    private

    def initialize
      @state = :out
    end

    def parse! options
      root = node = Context.new(filename: @filename)
      ctxt = nil
      @input.each_with_index do |line, lnb|
        parser = self.class.parsers.fetch(@state)
        @state, node, ctxt = parser.parse(line, lnb.succ, node, ctxt, options)
      end
      root
    end
  end
end
