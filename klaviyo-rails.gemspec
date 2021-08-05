# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'klaviyo-rails/version'
Gem::Specification.new do |spec|
  spec.name          = 'klaviyo-rails'
  spec.version       = KlaviyoRails::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ['Maxim Pechnikov']
  spec.email         = ['parallel588@gmail.com']

  spec.description = %q{The Klaviyo Rails Gem is a drop-in plug-in for ActionMailer to send emails via Klaviyo, an email delivery service for web apps.}
  spec.homepage = %q{http://klaviyo.com}
  spec.summary = %q{Klaviyo adapter for ActionMailer}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'parallel588-klaviyo', '~> 0.16.0'

  spec.add_development_dependency "bundler", "~> 2.2.10"
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
