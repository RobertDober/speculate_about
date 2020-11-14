require_relative '../speculations'
class Speculations::Parser
  require_relative './parser/context'
  require_relative './parser/state'

  attr_reader :alternate_syntax, :filename, :input, :orig_filename, :root, :state

  def self.parsers
     @__parsers__ ||= {
       bef: State::Bef,
       exa: State::Exa,
       inc: State::Inc,
       out: State::Out
     }
  end

  def parse_from_file file, orig_filename = nil, alternate_syntax: false
    @alternate_syntax = alternate_syntax
    @filename = file
    @orig_filename = orig_filename || file
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
    root = node = Context.new(alternate_syntax: alternate_syntax, name: "Speculations from #{@filename}", lnb: 0, filename: @filename, orig_filename: orig_filename, parent: nil)
    input.each_with_index do |line, lnb|
      @state, node = self.class.parsers.fetch(@state).parse(line, lnb.succ, node)
    end
    root
  end
end
