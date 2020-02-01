class Speculations::Parser::Context
  require_relative './context/include'
  require_relative './context/example'
  require_relative './context/setup'

  attr_reader :filename, :level, :lnb, :name, :parent, :setup

  def add_child(name:, lnb:)
    raise "Illegal nesting" if parent
    children << self.class.new(name: name, lnb: lnb, parent: self)
    children.last
  end

  def add_example(lnb:)
    examples << Example.new(lnb: lnb, parent: self)
    examples.last
  end

  def add_include(lnb:)
    includes << Include.new(lnb: lnb, parent: self)
    includes.last
  end

  def children
     @__children__ ||= []
  end

  def examples
     @__examples__ ||= []
  end

  def includes
     @__includes__ ||= []
  end

  def map_lines(*lines, indent: 0)
    prefix = "  " * (level + indent)
    lines.flatten.map{ |line| "#{prefix}#{line.strip}" }.join("\n")
  end

  def set_setup(lnb:)
    @setup = Setup.new(lnb: lnb, parent: self)
  end

  def to_code
    [
      _header,
      includes.map(&:to_code),
      setup&.to_code,
      examples.map(&:to_code),
      children.map(&:to_code),
      _footer
    ].flatten.compact.join("\n")
  end
  
  private

  def initialize(lnb:, name:, filename: nil, parent: nil)
    _init_from_parent filename, parent
    @level    = parent ? parent.level.succ : 1
    @lnb      = lnb
    @setup    = nil
    @name     = name
    @parent   = parent
  end

  def _header
    map_lines(%{context "#{name}" do}, indent: -1)
  end

  def _init_from_parent filename, parent
    @filename = parent ? parent.filename : filename
    raise ArgumentError, "no filename given in root context" unless @filename
  end

  def _footer
    map_lines("end", indent: -1)
  end

end
