# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_messages_huacnlee}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Pfeifer"]
  s.date = %q{2010-03-07}
  s.description = %q{has_messages fork for Rails 3, Demonstrates a reference implementation for sending messages between users in ActiveRecord}
  s.email = %q{aaron@pluginaweek.org}
  s.files = Dir.glob("lib/**/*") + %w(init.rb README.rdoc)
  s.homepage = %q{http://www.pluginaweek.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pluginaweek}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Demonstrates a reference implementation for sending messages between users in ActiveRecord}
  s.test_files = Dir.glob("test/**/*")

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<state_machine>, [">= 0.7.0"])
    else
      s.add_dependency(%q<state_machine>, [">= 0.7.0"])
    end
  else
    s.add_dependency(%q<state_machine>, [">= 0.7.0"])
  end
end
