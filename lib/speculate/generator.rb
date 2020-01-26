require_relative './parser.rb'
module Speculate::Generator extend self
  Error = Class.new RuntimeError

  def generate pair
    unless pair.outdated?
      raise Error,
        "Must not call generate for #{pair.speculation.path} -> #{pair.spec.path}, because it is not outdated"
    end
    puts "Generating: #{pair.speculation.path} -> #{pair.spec.path}"
    text = Speculate::Parser.new(pair.speculation).parse
    File.open(pair.spec.path, "w"){ |f|
      f.puts _header(pair.speculation.path)
      f.puts text
      f.puts _footer
    }
  end


  private

  def _footer
    %{end}
  end

  def _header name
    %{RSpec.describe #{name.inspect} do}
  end
end
