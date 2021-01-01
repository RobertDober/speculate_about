
module Speculations
  module CLI extend self
    def run args
      loop do
      case args.first
        when "-h", "--help"
          _usage
        when "-v", "--version"
          _version
        else
          return _compile_and_maybe_run args
        end
      end
    end

    private

    def _compile_and_maybe_run args
      require_relative "../speculations"
      args = Dir.glob(["*.md", "speculations/**/*.md"]) if args.empty?
        args.each do |input_file|
          Speculations.compile(input_file)
        end
    end

    def _usage
      puts <<-EOF
      usage:
        #{$0} [options] [filenames]

        options:
          -h | --help display this exit with -1
          -v | --version display version of the speculate_about gem exit with -2

        filenames (default to all markdown files in the project directory and its speculations subdirectories)

        recreate outdated speculations in `spec/speculations/` 
      EOF
      exit -1
    end

    def _version
      require_relative 'version'
      puts VERSION
      exit -2
    end
  end
end
