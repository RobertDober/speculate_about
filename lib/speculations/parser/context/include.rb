class Speculations::Parser::Context::Include

  attr_reader :lnb, :parent

  def add_line line 
    lines << line
    self
  end

  def lines
     @__lines__ ||= []
  end

  private

  def initialize(parent:, lnb:)
    @parent = parent
    @lnb    = lnb
  end
end
