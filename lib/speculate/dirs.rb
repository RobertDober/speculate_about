require 'fileutils'

require_relative './spec_pair'
module Speculate::Dirs extend self
  Error = Class.new RuntimeError

  DEFAULT_BASENAME = "__default"
  SPECULATION_RGX  = %r{\ASPECULATE[-_]*(.*)\.md\z}

  attr_reader :base_dir

  def speculation_to_dir speculation_file, base_dir: "spec/speculations"
    @base_dir = base_dir

    _assure_dir
    speculation_file, spec_path = _assure_speculation speculation_file

    Speculate::SpecPair.new speculation_file, spec_path
  end


  private

  def _assure_dir
    FileUtils.mkdir_p(base_dir)
  end

  def _assure_speculation speculation_file
    match = SPECULATION_RGX.match(speculation_file)
    raise Error, "#{speculation_file} is not a speculation" unless match

    basename = match[1].empty? ? DEFAULT_BASENAME : match[1]
    specname = File.join(base_dir, "#{basename}_spec.rb")

    [speculation_file, specname]
  end

end
