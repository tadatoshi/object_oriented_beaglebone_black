require 'spec_helper'
require 'bigdecimal'

describe "Voltage measurement with voltage divider of 11:1, e.g. 51[kΩ] and 5.1[kΩ]", analog_input: true do

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

  it "should calculate the measuring voltage" do

    pin_key = "P9_40"
    higher_side_resistor_resistance = BigDecimal("51000") # [Ω] 
    lower_side_resistor_resistance = BigDecimal("5100") # [Ω]

    expected_voltage = BigDecimal("20").to_f
    expected_raw_value = (BigDecimal(expected_voltage.to_s) / BigDecimal("11")).to_f

    voltage_input = ObjectOrientedBeagleboneBlackExamples::VoltageMeasurement::VoltageInput.new(pin_key, higher_side_resistor_resistance: higher_side_resistor_resistance, lower_side_resistor_resistance: lower_side_resistor_resistance)

    # Since the real "slots" file creates a directory structure when a device tree overlay is written to it, 
    # in the "test" environment with a regular file, it is mimiced here.
    mimic_internal_analog_input_directory_creation(pin_key, expected_raw_value) if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'

    expect(Dir.exists?(Dir["#{File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"], "helper.")}*"].first)).to be true

    expect(voltage_input.value).to be_within(0.1).of(expected_voltage)

  end

end