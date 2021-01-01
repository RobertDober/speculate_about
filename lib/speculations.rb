require 'fileutils'
require_relative 'speculations/parser'
module Speculations extend self

  def compile(infile, outfile=nil)
    raise ArgumentError, "#{infile} not found" unless File.readable? infile
    outfile ||= _speculation_path(infile)
    if _out_of_date?(outfile, infile)
      ast  = Speculations::Parser.new.parse_from_file(infile)
      File.write(outfile, ast.to_code.join("\n"))
    end
    outfile
  end

  private

  def _out_of_date?(outf, inf)
    return true unless File.exists? outf
    return File.lstat(outf).mtime <= File.lstat(inf).mtime
  end

  def _speculation_path(file)
    dir = File.dirname(file)
    dest_dir = File.join("spec", "speculations", dir)
    FileUtils.mkdir_p(dest_dir) unless File.directory?(dest_dir)
    rspec = File.basename(file, ".md")
    File.join(dest_dir, "#{rspec}_spec.rb")
  end
end
