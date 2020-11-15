module Speculations::Parser::State extend self
  require_relative './state/bef'
  require_relative './state/exa'
  require_relative './state/inc'
  require_relative './state/out'

  BEFORE_RGX  = %r[\A\s{0,3}```.*\s:before]
  CONTEXT_RGX = %r[\A\s{0,3}\#{1,7}\s+Context\s+(.*)]
  EOBLOCK_RGX = %r[\A\s{0,3}```\s*\z]
  EXAMPLE_RGX = %r[\A\s{0,3}```.*\s:example]
  GIVEN_RGX   = %r[\A\s{0,3}(?:Given|When)\b]
  INCLUDE_RGX = %r[\A\s{0,3}```.*\s:include]
  NAME_RGX    = %r[\A\s{0,3}Example:?\s+(.*)]i
  RUBY_RGX    = %r[\A\s{0,3}```ruby]
  THEN_RGX    = %r[\A\s{0,3}Then\s+(.*)]
  WS_RGX      = %r[\A\s*\z]

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
  
  def given_match line
    GIVEN_RGX =~ line
  end

  def include_match line
    INCLUDE_RGX =~ line
  end

  def potential_name line
    NAME_RGX.match(line)
  end

  def ruby_match line
    RUBY_RGX =~ line
  end

  def then_match line
    THEN_RGX.match(line)
  end

  def ws_match line
    WS_RGX =~ line
  end
end
