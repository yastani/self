# -*- encoding: utf-8 -*-
# stub: capistrano-rsync 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-rsync"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Andri M\u{f6}ll"]
  s.date = "2013-10-13"
  s.description = "Deploy with Rsync to your server from any local (or remote) repository. \n\nSaves you the need to install Git on your production machine and deploy all of your development files each time! \n\nWorks with the new Capistrano v3! Suitable for deploying any apps, be it Ruby or Node.js."
  s.email = "andri@dot.ee"
  s.homepage = "https://github.com/moll/capistrano-rsync"
  s.licenses = ["LAGPL"]
  s.rubygems_version = "2.4.5.2"
  s.summary = "Deploy with Rsync from any local (or remote) repository. Capistrano v3 ready!"

  s.installed_by_version = "2.4.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, ["< 4", ">= 3.0.0.pre14"])
    else
      s.add_dependency(%q<capistrano>, ["< 4", ">= 3.0.0.pre14"])
    end
  else
    s.add_dependency(%q<capistrano>, ["< 4", ">= 3.0.0.pre14"])
  end
end
