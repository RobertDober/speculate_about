require 'rspec'
require_relative 'speculations/parser'
module SpeculateAbout

  def speculate_about(infile)
    raise ArgumentError, "#{infile} not found" unless File.readable? infile
    ast  = Speculations::Parser.new.parse_from_file(infile)
    code = ast.to_code.join("\n")
    ENV["SPECULATE_ABOUT_DEBUG"] ? _show(code, infile) : instance_eval(code, infile)
  end

  private
  def _show(code, path)
     message = "Generated code for #{path}"
     _underline(message)
     puts code
  end
  def _underline(message, ul: "=")
    puts message
    puts message.gsub(/./, ul)
  end

end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
#  SPDX-License-Identifier: Apache-2.0
