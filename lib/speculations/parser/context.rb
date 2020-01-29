class Speculations::Parser::Context
  require_relative './context/include'
  require_relative './context/example'
  require_relative './context/setup'

  attr_reader :lnb, :name, :parent, :setup

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

  def set_setup(lnb:)
    @setup = Setup.new(lnb: lnb, parent: self)
  end
  
  private

  def initialize(name:, lnb:, parent: nil)
    @setup = nil
    @name  = name
    @parent = parent
  end
end
