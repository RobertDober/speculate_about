require_relative "lib/speculations/version.rb"
Gem::Specification.new do |s|
  s.name        = 'speculate_about'
  s.version     = Speculations::VERSION
  s.date        = Time.new.strftime('%Y-%m-%d')
  s.summary     = 'Extract RSpecs from Markdown'
  s.description = 'Allows Markdown or other text files to be used as literal specs, à la Elixr doctest, but from any file.'
  s.authors     = ['Robert Dober']
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob('{lib,bin}/**/*.rb')
  s.bindir      = 'bin'
  s.executables << 'speculate'
  s.homepage    =
    'https://github.com/robertdober/speculate'
  s.license       = 'Apache-2.0'

  s.required_ruby_version = '>= 3.1.0'
end

#  SPDX-License-Identifier: Apache-2.0
