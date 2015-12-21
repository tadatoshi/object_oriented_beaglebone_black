require 'pry'
require "object_oriented_beaglebone_black/version"
require "erb"

OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT = File.expand_path('..', __dir__)

require 'yaml'
# require 'active_support/core_ext/hash/keys'

ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] ||= 'development'
OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG = YAML.load(ERB.new(File.read(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT, "config", "environments", "#{ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"]}.yml"))).result)
# YAML.load_file(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT, "config", "environments", "#{ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"]}.yml"))
# In order not to use activesupport (since Beaglebone Black that is used currently didn't have Internet access to download it), Hash#deep_symbolize_keys! is not used.
# OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG.deep_symbolize_keys!

require 'object_oriented_beaglebone_black/pin_mappings'
require 'object_oriented_beaglebone_black/uart_mappings'
require 'object_oriented_beaglebone_black/io'
require 'object_oriented_beaglebone_black/io/direction'
require 'object_oriented_beaglebone_black/io/value'
require 'object_oriented_beaglebone_black/gpio'
require 'object_oriented_beaglebone_black/led'
require 'object_oriented_beaglebone_black/pwm'
require 'object_oriented_beaglebone_black/analog_input'
require 'object_oriented_beaglebone_black/uart_connection'

module ObjectOrientedBeagleboneBlack
  # Your code goes here...
end