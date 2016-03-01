source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [version, { :git => $1, :branch => $2, :require => false}].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false}]
  else
    [place, version, { :require => false}].compact
  end
end

group :development, :unit_tests do
  gem 'rake',                    :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'puppet-lint',             :require => false
  gem 'metadata-json-lint',      :require => false
end
group :system_tests do
  gem 'beaker-rspec',                  *location_for(ENV['BEAKER_RSPEC_VERSION'] || '>= 3.4')
  gem 'beaker',                        *location_for(ENV['BEAKER_VERSION'])
  gem 'serverspec',                    :require => false
  gem 'beaker-puppet_install_helper',  :require => false
end

gem 'facter', *location_for(ENV['FACTER_GEM_VERSION'])
gem 'puppet', *location_for(ENV['PUPPET_GEM_VERSION'])
gem 'rspec',  *location_for(ENV['RSPEC_GEM_VERSION'])

if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end

# vim:ft=ruby
