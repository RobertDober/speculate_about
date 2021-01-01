class Speculations::Parser::Context::Example

  attr_reader :lnb, :title, :parent


  def add_line line
    lines << line
    self
  end

  def lines
     @__lines__ ||= [] 
  end

  def to_code
    parent.map_lines(_example_head) +
      parent.map_lines(lines, indent: 1) +
      parent.map_lines("end")
  end


  private

  def initialize(lnb:, parent:, title:)
    @lnb    = lnb
    @parent = parent
    @title  = _compute_title(title)
  end

  def _compute_title(title)
    "#{title} (#{parent.root.filename}:#{lnb})"
  end

  def _example_head
    %{it "#{title}" do}
  end
end
