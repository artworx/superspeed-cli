# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','superspeed-cli','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'superspeed-cli'
  s.version = SuperspeedCli::VERSION
  s.author = 'Alexandru Keszeg'
  s.email = 'akeszeg@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Cli wrapper for superspeed'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','superspeed-cli.rdoc']
  s.rdoc_options << '--title' << 'superspeed-cli' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'superspeed-cli'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('pry')
  s.add_runtime_dependency('gli','2.13.1')
  s.add_runtime_dependency('mechanize','2.7.3')
  s.add_runtime_dependency('execjs','2.5.2')
  s.add_runtime_dependency('virtus','1.0.1')
  s.add_runtime_dependency('highline','1.7.2')
  s.add_runtime_dependency('table_print','1.5.3')
end
