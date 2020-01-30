class Speculations::Parser::Context::Example

  attr_reader :lnb, :name, :parent

  def add_line line
    lines << line
    self
  end

  def lines
     @__lines__ ||= [] 
  end

  def to_code
    parent.map_lines(_example_head) +
      "\n" +
      parent.map_lines(lines, indent: 1) +
      "\n" +
      parent.map_lines("end")
  end


  private

  def initialize(lnb:, parent:)
    @lnb    = lnb
    @name   = "Example from #{parent.filename}:#{lnb.succ}"
    @parent = parent
  end

  def _example_head
    %{it "#{name}" do}
  end
end
