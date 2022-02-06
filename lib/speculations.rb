require 'fileutils'
require_relative 'speculations/parser'
module Speculations extend self

      DISCLAIMER = <<-EOD
# DO NOT EDIT!!!
# This file was generated from FILENAME with the speculate_about gem, if you modify this file
# one of two bad things will happen
# - your documentation specs are not correct
# - your modifications will be overwritten by the speculate rake task
# YOU HAVE BEEN WARNED
      EOD

  def compile(infile, outfile=nil)
    raise ArgumentError, "#{infile} not found" unless File.readable? infile
    outfile ||= _speculation_path(infile)
    if _out_of_date?(outfile, infile)
      ast  = Speculations::Parser.new.parse_from_file(infile)
      code = _decorated_ast_code ast, infile
      File.write(outfile, code.join("\n"))
    end
    outfile
  end

  private

  def _decorated_ast_code ast, filename
    [DISCLAIMER.gsub("FILENAME", filename.inspect).split("\n"), %{RSpec.describe #{filename.inspect} do}] +
    ast.to_code + ["end"]
  end

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
