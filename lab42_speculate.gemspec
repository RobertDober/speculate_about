Gem::Specification.new do |s|
  s.name        = 'lab42_speculate'
  s.version     = '0.0.4'
  s.date        = '2020-01-26'
  s.summary     = 'Extract RSpecs from Markdown'
  s.description = 'Extract RSpecs from Markdown'
  s.authors     = ['Robert Dober']
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob('lib/**/*.rb')
  s.homepage    =
    'https://github.com/robertdober/speculate'
  s.license       = 'Apache-2.0'

  s.required_ruby_version = '>= 2.7.0'
  s.executables << 'speculate' 

  s.add_dependency 'parser', '~> 2.7.0'

  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'pry-byebug', '~> 3.7'
end

