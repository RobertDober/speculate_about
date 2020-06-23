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

  def initialize(lnb:, line:, parent:, name: nil)
    @lnb    = lnb
    @parent = parent
    @name   = _compute_name(lnb: lnb, line: line, parent: parent, name: name)
  end

  def _compute_name(lnb:, parent:, line:, name:)
    _, name1 = NAMED_EXAMPLE.match(line).to_a
    
    if name1&.empty? == false # SIC
      "#{name1} (#{parent.orig_filename}:#{lnb.succ})"
    elsif name
      "#{name} (#{parent.orig_filename}:#{lnb.succ})"
    else
      "Example from #{parent.orig_filename}:#{lnb.succ}"
    end
  end

  def _example_head
    %{it "#{name}" do}
  end
end
