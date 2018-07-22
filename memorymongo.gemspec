$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "memorymongo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "memorymongo"
  s.version     = MemoryMongo::VERSION
  s.authors     = ["Vladislav Belov"]
  s.email       = ["vladik.by@gmail.com"]
  s.homepage    = "https://github.com/vbelov/memorymongo"
  s.summary     = "Simple in-process Mongo implementation."
  s.description = "Simple in-process Mongo implementation."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "awesome_print"
  s.add_dependency "hashie"
  s.add_dependency "mongoid"
  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "virtus"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "spring"
  s.add_development_dependency "spring-commands-rspec"
end
