require 'spec_helper'
require 'fileutils'

describe BeagleboneBlackRuby::Led do

  before(:each) do
    FileUtils.mkdir_p(BEAGLEBONE_BLACK_RUBY_CONFIG["io_root_directory"], mode: 0700) unless Dir.exists?(BEAGLEBONE_BLACK_RUBY_CONFIG["io_root_directory"])
  end
  
  it "should light LED 0 (mimicking http://192.168.7.2/Support/BoneScript/demo_blinkled/)" do

    led = "USR0"
    state = 1

    led_0 = BeagleboneBlackRuby::Led.new(led)

    # Instead of pin_mode(pin_name, pin_mode), setting the pin_mode is responsibility of pin object (Led here). 
    # i.e. ordinary Object-Oriented way. 
    led_0.pin_mode = 'out'

    # Instead of digital_write(pin_name, state), setting the state is responsibility of pin object (Led here). 
    # i.e. ordinary Object-Oriented way. 
    led_0.digital_write(state)

    expect(led_0.state).to eq(state)

  end

end