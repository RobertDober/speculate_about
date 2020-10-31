require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    paths = _find_files(file, File.dirname( caller.first ))
    raise ArgumentError, "no files found for pattern #{file}" if paths.empty?
    paths.each do |path|
      code = _compile path, file
      ENV["SPECULATE_ABOUT_DEBUG"] ? puts(code) : instance_eval(code)
    end
  end


  private

  def _compile path, file
    ast  = Speculations::Parser.new.parse_from_file(path, file)
    ast.to_code
  end
  def _find_files file, local_path
    [Dir.pwd, local_path]
      .flat_map do |dir|
        Dir.glob(File.join(dir, file))
    end
  end
end

RSpec.configure do |conf|
  conf.extend SpeculateAbout
end
