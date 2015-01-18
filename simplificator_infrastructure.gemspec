$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simplificator_infrastructure/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simplificator_infrastructure"
  s.version     = SimplificatorInfrastructure::VERSION
  s.authors     = ["Pascal Betz"]
  s.email       = ["pascal.betz@simplificator.com"]
  s.homepage    = "http://www.simplificator.com"
  s.summary     = "Infrastructure support for Rails Apps"
  s.description = "Infrastructure support for Rails Apps"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
end
