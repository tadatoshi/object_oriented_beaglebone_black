require 'spec_helper'
require 'fileutils'
require 'bigdecimal'

describe "ObjectOrientedBeagleboneBlack::AnalogInput", analog_input: true do

  before(:each) do

    @slots_directory = OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"]
    @device_directory = OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"]

    # In order to run this spec example in the real environment, the directories and files that already exist there are not created in that case. 
    if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'
      FileUtils.mkdir_p(@slots_directory, mode: 0700) unless Dir.exists?(@slots_directory)
      FileUtils.touch(File.join(@slots_directory, "slots"))
      File.chmod(0700, File.join(@slots_directory, "slots"))

      FileUtils.mkdir_p(@device_directory, mode: 0700) unless Dir.exists?(@device_directory)         
    end
  end

  after(:each) do
    if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'
      File.open(File.join(@slots_directory, "slots"), 'w') {|file| file.truncate(0) }
    end
  end
  
  it "should read the value of the specified analog input pin" do

    pin_key = "P9_40"
    expected_raw_value = (BigDecimal("1630") / BigDecimal("1000")).to_f
    expected_value = (BigDecimal(expected_raw_value.to_s) * (BigDecimal("1.0")/BigDecimal("1.8"))).to_f

    analog_input = ObjectOrientedBeagleboneBlack::AnalogInput.new(pin_key)

    # Since the real "slots" file creates a directory structure when a device tree overlay is written to it, 
    # in the "test" environment with a regular file, it is mimiced here.
    mimic_internal_analog_input_directory_creation(pin_key, expected_raw_value) if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'

    expect(Dir.exists?(Dir["#{File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"], "helper.")}*"].first)).to be true

    # Instead of analog_read(pin_name), reading the value is responsibility of pin object. 
    # i.e. ordinary Object-Oriented way. 
    expect(analog_input.raw_value).to eq(expected_raw_value)
    expect(analog_input.value).to eq(expected_value)

  end

end