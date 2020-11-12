require 'rspec'

require 'speculations/parser'

module SpeculateAbout
  def speculate_about file
    paths = _find_files(file, File.dirname( caller.first ))
    raise ArgumentError, "no files found for pattern #{file}" if paths.empty?
    paths.each do |path|
      code = _compile path, _readable(path) 
      ENV["SPECULATE_ABOUT_DEBUG"] ? _show(code, path) : instance_eval(code, path)
    end
  end


  private

  def _compile path, file
    ast  = Speculations::Parser.new.parse_from_file(path, file)
    ast.to_code
  end
  def _readable(path)
    d = File.dirname(path)
    File.join(File.basename(d), File.basename(path))
  end
  def _find_files file, local_path
    [Dir.pwd, local_path]
      .flat_map do |dir|
        Dir.glob(File.join(dir, file))
    end
  end
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
