require 'spec_helper'
require 'fileutils'

describe BeagleboneBlackRuby::Led do

  before(:each) do
    FileUtils.mkdir_p(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, BEAGLEBONE_BLACK_RUBY_CONFIG[:io_root_directory]), mode: 0700) unless Dir.exists?(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, BEAGLEBONE_BLACK_RUBY_CONFIG[:io_root_directory]))
  end
  
  it "should light LED 1" do

    led = "USR0"
    state = 0

    led_0 = BeagleboneBlackRuby::Led.new(led)

    pending

    led_0.pin_mode('out')


  end

end