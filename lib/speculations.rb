require 'fileutils'
require 'speculations/parser'
module Speculations extend self

  def compile(file)
    raise ArgumentError, "#{file} not found" unless File.readable? file
    ast  = Speculations::Parser.new.parse_from_file(file)
    File.write(_speculation_path(file), ast.to_code)
  end

  private

  def _speculation_path(file)
    dir = File.dirname(file)
    dest_dir = File.join("spec", "speculations", dir)
    FileUtils.mkdir_p(dest_dir) unless File.directory?(dest_dir)
    rspec = File.basename(file, ".md")
    File.join(dest_dir, "#{rspec}_spec.rb")
  end
end
