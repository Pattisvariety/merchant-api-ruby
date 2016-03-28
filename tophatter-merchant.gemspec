# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'tophatter_merchant/version'

Gem::Specification.new do |s|
  s.name        = 'tophatter-merchant'
  s.version     = TophatterMerchant::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ['Chris Estreich']
  s.email       = ['chris@tophatter.com']
  s.homepage    = 'https://github.com/tophatter/merchant-api-ruby'
  s.summary     = 'The Tophatter merchant platform is an e-commerce platform. It allows merchants to upload and manage inventory for sale on Tophatter.'
  s.description = 'The Tophatter merchant platform is an e-commerce platform. It allows merchants to upload and manage inventory for sale on Tophatter.'

  s.required_ruby_version = '~> 2.0'

  s.add_dependency 'rest-client'
  s.add_dependency 'hashie'
  s.add_dependency 'activemodel'

  s.post_install_message = 'Documentation is available at: https://tophatter.readme.io/'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
