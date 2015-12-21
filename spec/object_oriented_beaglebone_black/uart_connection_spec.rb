require 'spec_helper'
require 'fileutils'
require 'bigdecimal'

describe "ObjectOrientedBeagleboneBlack::UartConnection" do

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
    
    uart_connection = ObjectOrientedBeagleboneBlack::UartConnection.new(uart_id)

    # TODO: The following requires serial connection. Find a way to test it. 
    # uart_connection.read(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1)

  end

end