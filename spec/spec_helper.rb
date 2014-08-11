ENV["BEAGLEBONE_BLACK_RUBY_ENV"] ||= 'test'

require 'beaglebone_black_ruby'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.expand_path('support/**/*.rb', __dir__))].each {|f| require f}

RSpec.configure do |c|
  c.include GpioFileBehaviorHelper, gpio: true
end