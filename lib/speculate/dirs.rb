require 'fileutils'

require_relative './spec_pair'
module Speculate::Dirs extend self
  Error = Class.new RuntimeError

  DEFAULT_BASENAME = "__default"
  SPECULATION_RGX  = %r{\ASPECULATE[-_]*(.*)\.md\z}

  attr_reader :base_dir

  def speculation_to_dir speculation_file, base_dir
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

    basename = File.basename(speculation_file).sub(%r{\..*\z}i, "").downcase
    specname = File.join(base_dir, "#{basename}_spec.rb")

    [speculation_file, specname]
  end

end
