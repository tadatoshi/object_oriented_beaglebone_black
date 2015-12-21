require 'spec_helper'

describe ObjectOrientedBeagleboneBlack::UartMappings do
  
  class TestUartMappingsClass
    include ObjectOrientedBeagleboneBlack::UartMappings
  end

  before(:each) do
    @test_uart_mappings = TestUartMappingsClass.new
  end

  it "should get Hash for UART4" do

    expect(@test_uart_mappings.property_hash(id: "UART4")).to eq({"teletype_device_path" => "/dev/ttyO4", 
                                                                  "devicetree" => "BB-UART4", 
                                                                  "rx" => "P9_11", 
                                                                  "tx" => "P9_13"})

  end

end