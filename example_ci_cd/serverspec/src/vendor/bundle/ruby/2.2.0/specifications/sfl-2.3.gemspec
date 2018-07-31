# -*- encoding: utf-8 -*-
# stub: sfl 2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "sfl"
  s.version = "2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["ujihisa", "blambeau"]
  s.date = "2016-10-03"
  s.description = "Spawn For Ruby 1.8"
  s.email = "ujihisa at gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "https://github.com/ujihisa/spawn-for-legacy"
  s.licenses = ["Ruby"]
  s.rubygems_version = "2.4.5.2"
  s.summary = "Spawn For Ruby 1.8"

  s.installed_by_version = "2.4.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.4.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.4.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.4.0"])
  end
end
