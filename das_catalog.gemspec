# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "das_catalog/version"

Gem::Specification.new do |s|
  s.name        = 'das_downloader'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Brendon Murphy'
  s.email       = 'xternal1+github@gmail.com'
  s.summary     = 'Download screencasts from Destroy All Software catalog'
  s.description = 'Download screencasts from Destroy All Software catalog.  Uses the rss feed plus Mechanize to log you in and then download new movies to your local drive.'

  s.files         = Dir['lib/**/*.rb'] + Dir['bin/*'] + %w(README.md LICENSE)
  s.test_files    = Dir['spec/**/*.rb']
  s.require_path  = 'lib'

  s.executables = ["das_catalog_sync"]

  s.add_dependency('feedzirra')
  s.add_dependency('mechanize')
  s.add_dependency('highline')

  s.add_development_dependency('minitest')
  s.add_development_dependency('mocha')
  s.add_development_dependency('fakefs')
end
