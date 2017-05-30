# -*- encoding: utf-8 -*-

# To publish the next version:
# gem build tophatter-merchant.gemspec
# gem push tophatter-merchant-{VERSION}.gem
Gem::Specification.new do |s|
  s.name        = 'tophatter-merchant'
  s.version     = '1.2.0'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ['Chris Estreich']
  s.email       = ['chris@tophatter.com']
  s.homepage    = 'https://github.com/tophatter/merchant-api-ruby'
  s.summary     = 'Manage your inventory and fulfill orders on Tophatter.'
  s.description = 'The Tophatter merchant platform is an e-commerce platform. It allows merchants to manage inventory and fulfill orders on Tophatter.'

  s.extra_rdoc_files = ['README.md']

  s.required_ruby_version = '~> 2.0'

  s.add_dependency 'rest-client', '~> 1.6'
  s.add_dependency 'activemodel', '~> 4.2'

  s.post_install_message = 'Documentation is available at: https://tophatter.readme.io/'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
