$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simplificator_infrastructure/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simplificator_infrastructure"
  s.version     = SimplificatorInfrastructure::VERSION
  s.authors     = ["Pascal Betz"]
  s.email       = ["pascal.betz@simplificator.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SimplificatorInfrastructure."
  s.description = "TODO: Description of SimplificatorInfrastructure."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
end
