require 'spec_helper'
require 'fileutils'
require 'bigdecimal'

describe "Convert duty cycle and sent to Arduino Due through UART connection" do

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
  
  it "should sent the value through the specified UART connection" do

    uart_id = "UART4"
    # The parameters for Arduino Due:
    pwm_steps = BigDecimal("255")

    uart_connection_double = double(uart_id)
    
    pwm_output = ObjectOrientedBeagleboneBlackExamples::UartConnectionToArduino::PwmOutput.new(uart_connection_double, pwm_steps)

    expect(uart_connection_double).to receive(:write).with(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: 'p127')

    pwm_output.send(0.5)

  end

end