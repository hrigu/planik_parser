# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'planik_parser'
  s.version = '0.0.1'

  s.authors = ['Christian Muehlethaler']
  s.email = 'christian.muehlethlaer@planik.ch'
  s.extra_rdoc_files = ['README']
  s.files = %w(HISTORY.txt LICENSE Rakefile README) + Dir.glob("{lib,example}/**/*")
  s.homepage = 'http://planik.ch'
  s.rdoc_options = ['--main', 'README']
  s.require_paths = ['lib']
  s.summary = 'Parser for the planik rules.'

  s.add_dependency 'parslet', '~> 1.5'
  #s.add_dependency 'blankslate', '~> 2.0'

  %w(rspec rdoc sdoc guard guard-rspec rb-fsevent growl).
    each { |gem_name| 
      s.add_development_dependency gem_name }
end
