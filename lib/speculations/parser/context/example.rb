class Speculations::Parser::Context::Example

  attr_reader :lnb, :name, :parent

  def add_line line
    lines << line
    self
  end

  def lines
     @__lines__ ||= [] 
  end

  private

  def initialize(lnb:, file: nil, parent:)
    @lnb    = lnb
    @name   = "Example #{file} at line #{lnb}"
    @parent = parent
  end
end
