require "beaglebone_black_ruby/version"

BEAGLEBONE_BLACK_RUBY_ROOT = File.expand_path('..', __dir__)

require 'yaml'
# require 'active_support/core_ext/hash/keys'

ENV["BEAGLEBONE_BLACK_RUBY_ENV"] ||= 'development'
BEAGLEBONE_BLACK_RUBY_CONFIG = YAML.load_file(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, "config", "environments", "#{ENV["BEAGLEBONE_BLACK_RUBY_ENV"]}.yml"))
# In order not to use activesupport (since Beaglebone Black that is used currently doesn't have Internet access to download it), Hash#deep_symbolize_keys! is not used.
# BEAGLEBONE_BLACK_RUBY_CONFIG.deep_symbolize_keys!

require 'beaglebone_black_ruby/pin_mappings'
require 'beaglebone_black_ruby/io'
require 'beaglebone_black_ruby/io/direction'
require 'beaglebone_black_ruby/io/value'
require 'beaglebone_black_ruby/gpio'
require 'beaglebone_black_ruby/led'

module BeagleboneBlackRuby
  # Your code goes here...
end