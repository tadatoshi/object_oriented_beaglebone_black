require "beaglebone_black_ruby/version"

BEAGLEBONE_BLACK_RUBY_ROOT = File.expand_path('..', __dir__)

require 'yaml'
require 'active_support/core_ext/hash/keys'

BEAGLEBONE_BLACK_RUBY_ENV ||= 'development'
BEAGLEBONE_BLACK_RUBY_CONFIG = YAML.load_file(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, "config", "environments", "#{BEAGLEBONE_BLACK_RUBY_ENV}.yml"))
BEAGLEBONE_BLACK_RUBY_CONFIG.deep_symbolize_keys!

require 'beaglebone_black_ruby/pin_mappings'
require 'beaglebone_black_ruby/led'

module BeagleboneBlackRuby
  # Your code goes here...
end