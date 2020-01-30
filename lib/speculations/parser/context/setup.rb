class Speculations::Parser::Context::Setup

  attr_reader :lnb, :parent

  def add_line line
    lines << line
    self
  end

  def lines
     @__lines__ ||= []
  end

  def to_code
    parent.map_lines("before do") + 
      "\n" +
      parent.map_lines(lines, indent: 1) +
      "\n" +
      parent.map_lines("end")
  end


  private

  def initialize(lnb:, parent:)
    @parent = parent
  end
end
