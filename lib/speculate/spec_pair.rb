require 'fileutils'
class Speculate::SpecPair

  attr_reader :spec, :speculation

  def outdated?
    speculation.mtime >= spec.mtime
  end


  private

  def initialize speculation_name, spec_path 
    @speculation = File.new speculation_name

    FileUtils.touch(spec_path, mtime: speculation.mtime - 1) unless File.exists? spec_path
    @spec        = File.new spec_path
  end

  def _spec_pair basename
    specname = File.join(base_dir, "#{basename}_spec.rb")
    FileUtils.touch(specname, mtime: speculation.mtime - 1) unless File.exists? specname
    OpenStruct.new(speculation: speculation, spec: File.new(specname))
  end
  
end
