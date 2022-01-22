module Speculations::Parser::State::Triggers

  BLANK_RGX   = %r{\A\s*\z}
  CONTEXT_RGX = %r[\A\s{0,3}(?<level>\#{1,7})\s+Context:?\s+(?<title>.*)]
  EOBLOCK_RGX = %r[\A\s{0,3}```\s*\z]
  GIVEN_RGX   = %r[\A\s{0,3}(?:Given|When)\b]
  EXAMPLE_RGX = %r[\A\s{0,3}Example:?\s+(<?title>.*)]
  RUBY_RGX    = %r[\A\s{0,3}```ruby]
  THEN_RGX    = %r[\A\s{0,3}(?:Then|But|And|Also|Or)\b\s*(?<title>.*)]

  def blank_line line
    BLANK_RGX.match(line)
  end

  def context_match line
    CONTEXT_RGX.match(line)
  end

  def eoblock_match line
    EOBLOCK_RGX.match(line)
  end

  def maybe_example line
    EXAMPLE_RGX.match(line) ||
      THEN_RGX.match(line)
  end

  def maybe_include line
    GIVEN_RGX.match(line)
  end

  def ruby_code_block line
    RUBY_RGX.match(line)
  end
end
