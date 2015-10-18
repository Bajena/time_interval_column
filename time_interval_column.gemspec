$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "time_interval_column/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "time_interval_column"
  s.version     = TimeIntervalColumn::VERSION
  s.authors     = ["Jan Bajena"]
  s.email       = ["jan.bajena@o2.pl"]
  s.homepage    = "https://github.com/Bajena/time_interval_column"
  s.summary     = "Small gem which enables storing and using time intervals in Rails applications"
  s.description = "Small gem which enables storing and using time intervals in Rails applications"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "rspec-rails"

  s.add_development_dependency "sqlite3"
end
