module Speculations::Parser::State extend self
  require_relative './state/bef'
  require_relative './state/exa'
  require_relative './state/inc'
  require_relative './state/out'

  BEFORE_RGX  = %r[\A\s{0,3}```.*\s:before]
  CONTEXT_RGX = %r[\A\s{0,3}\#{1,7}\s+Context\s+(.*)]
  EOBLOCK_RGX = %r[\A\s{0,3}```\s*\z]
  EXAMPLE_RGX = %r[\A\s{0,3}```.*\s:example]
  INCLUDE_RGX = %r[\A\s{0,3}```.*\s:include]

  def before_match line
    BEFORE_RGX =~ line
  end

  def context_match line
    if match = CONTEXT_RGX.match(line)
      match.captures.first
    end
  end

  def eoblock_match line
    EOBLOCK_RGX =~ line
  end

  def example_match line
    EXAMPLE_RGX =~ line
  end

  def include_match line
    INCLUDE_RGX =~ line
  end
end
