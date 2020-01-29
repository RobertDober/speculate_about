class Speculations::Parser::Context::Setup

  attr_reader :lnb, :parent

  def add_line line
    lines << line
    self
  end

  def lines
     @__lines__ ||= []
  end


  private

  def initialize(lnb:, parent:)
    @parent = parent
  end
end
