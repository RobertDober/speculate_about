Gem::Specification.new do |s|
  s.name        = 'speculate_about'
  s.version     = '0.2.1'
  s.date        = '2020-06-23'
  s.summary     = 'Extract RSpecs from Markdown'
  s.description = 'Allows Markdown or other text files to be used as literal specs, à la Elixr doctest, but from any file.'
  s.authors     = ['Robert Dober']
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob('lib/**/*.rb')
  s.homepage    =
    'https://github.com/robertdober/speculate'
  s.license       = 'Apache-2.0'

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'rspec', '~> 3.9'

end

