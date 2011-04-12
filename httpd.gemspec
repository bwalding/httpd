# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{httpd}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Walding"]
  s.date = %q{2011-04-12}
  s.description = %q{Basic Ruby DSL for building HTTPD configuration}
  s.email = %q{ben@walding.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "httpd.gemspec",
    "lib/httpd.rb",
    "lib/httpd/alias_helper.rb",
    "lib/httpd/base.rb",
    "lib/httpd/block.rb",
    "lib/httpd/conf.rb",
    "lib/httpd/directory.rb",
    "lib/httpd/element.rb",
    "lib/httpd/httpd.rb",
    "lib/httpd/location.rb",
    "lib/httpd/raw.rb",
    "lib/httpd/raw_helper.rb",
    "lib/httpd/virtual_host.rb",
    "test-httpd.conf",
    "test/basic_test.rb",
    "test/basic_test_basic.txt",
    "test/helper.rb",
    "test/load_test.rb",
    "test/test2.rb"
  ]
  s.homepage = %q{http://github.com/bwalding/httpd}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Basic Ruby DSL for building HTTPD configuration}
  s.test_files = [
    "test/basic_test.rb",
    "test/helper.rb",
    "test/load_test.rb",
    "test/test2.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

