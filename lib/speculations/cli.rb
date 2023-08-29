# frozen_string_literal: true

require 'ostruct'
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
      state = _parse(args)
      require_relative "../speculations"
      positionals = Dir.glob(["*.md", "speculations/**/*.md"]) if state.positionals.empty?
      positionals.each do |input_file|
        Speculations.compile(input_file, OpenStruct.new(state.kwds).freeze)
      end
    end

    def _parse(args)
      args.inject(OpenStruct.new(kwds: {}, positionals: [], current: nil), &_parse_arg)
    end

    def _parse_arg
      -> state, arg do
        if arg == '--verbose'
          state.kwds.update(verbose: true)
        elsif arg.start_with?('--')
          raise ArgumentError, "illegal option #{arg}"
        else
          state.positionals << arg
        end
        state
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
