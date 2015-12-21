ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] ||= 'test'

require 'object_oriented_beaglebone_black'
require 'object_oriented_beaglebone_black_examples'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.expand_path('support/**/*.rb', __dir__))].each {|f| require f}

RSpec.configure do |c|
  c.include GpioFileBehaviorHelper, gpio: true
  c.include PwmFileBehaviorHelper, pwm: true
  c.include AnalogInputFileBehaviorHelper, analog_input: true
end