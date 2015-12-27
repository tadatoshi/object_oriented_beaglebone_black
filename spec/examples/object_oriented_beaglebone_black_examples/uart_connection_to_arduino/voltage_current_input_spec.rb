require 'spec_helper'
require 'fileutils'
require 'bigdecimal'

describe "Extract voltage and current from the measured values by Arduino Due through UART connection" do

  before(:each) do

    @slots_directory = OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"]

    # In order to run this spec example in the real environment, the directories and files that already exist there are not created in that case. 
    if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'
      FileUtils.mkdir_p(@slots_directory, mode: 0700) unless Dir.exists?(@slots_directory)
      FileUtils.touch(File.join(@slots_directory, "slots"))
      File.chmod(0700, File.join(@slots_directory, "slots"))
    end
  end

  after(:each) do
    if ENV["OBJECT_ORIENTED_BEAGLEBONE_BLACK_ENV"] == 'test'
      File.open(File.join(@slots_directory, "slots"), 'w') {|file| file.truncate(0) }
    end
  end
  
  it "should read the value through the specified UART connection" do

    uart_id = "UART4"
    # The parameters for Arduino Due:
    analog_steps = BigDecimal("4095")
    reference_voltage = BigDecimal("3.3")

    uart_connection_double = double(uart_id)
    
    voltage_current_input = ObjectOrientedBeagleboneBlackExamples::UartConnectionToArduino::VoltageCurrentInput.new(uart_connection_double, analog_steps, reference_voltage)

    expect(uart_connection_double).to receive(:read).with(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: 'm') do
                                        "{\"raw_reading_for_input_voltage\": 534, \"raw_reading_for_input_current\": 5, \"raw_reading_for_output_voltage\": 281}" 
                                      end

    voltage_current_input.measure

    # higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
    input_voltage = voltage_current_input.input_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))
    # shunt resistance: 0.04[Ω]
    input_current = voltage_current_input.input_current(resistance_for_current_measurement: BigDecimal("0.04"))
    # higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
    output_voltage = voltage_current_input.output_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))    

    expect(input_voltage).to be_within(0.1).of(BigDecimal("5.7"))
    expect(input_current).to be_within(0.1).of(BigDecimal("0.1"))
    expect(output_voltage).to be_within(0.1).of(BigDecimal("3.0"))

  end

end