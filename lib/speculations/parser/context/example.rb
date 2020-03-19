class Speculations::Parser::Context::Example

  attr_reader :lnb, :name, :parent

  NAMED_EXAMPLE = %r{\A[`~]{3,}ruby\s+:example\s+(.*)}

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

  def initialize(lnb:, line:, parent:)
    @lnb    = lnb
    @parent = parent
    @name   = _compute_name(lnb: lnb, line: line, parent: parent)
  end

  def _compute_name(lnb:, parent:, line:)
    _, name = NAMED_EXAMPLE.match(line).to_a
    
    if name&.empty? == false # SIC
      "#{name} (#{parent.orig_filename}:#{lnb.succ})"
    else
      "Example from #{parent.orig_filename}:#{lnb.succ}"
    end
  end

  def _example_head
    %{it "#{name}" do}
  end
end
