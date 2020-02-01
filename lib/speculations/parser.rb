require_relative '../speculations'
class Speculations::Parser
  require_relative './parser/context'
  require_relative './parser/state'

  attr_reader :filename, :input, :root, :state

  def self.parsers
     @__parsers__ ||= {
       bef: State::Bef,
       exa: State::Exa,
       inc: State::Inc,
       out: State::Out
     }
  end

  def parse_from_file file
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
    root = node = Context.new(name: "Speculations from #{@filename}", lnb: 0, filename: @filename, parent: nil)
    input.each_with_index do |line, lnb|
      @state, node = self.class.parsers.fetch(@state).parse(line, lnb.succ, node)
    end
    root
  end
end
