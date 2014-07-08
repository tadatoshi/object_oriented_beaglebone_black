require 'spec_helper'

describe BeagleboneBlackRuby::PinMappings do
  
  class TestPinMappingsClass
    include BeagleboneBlackRuby::PinMappings
  end

  before(:each) do
    @test_pin_mappings = TestPinMappingsClass.new
  end

  it "should get Hash for USR0 pin" do

    expect(@test_pin_mappings.property_hash("USR0")).to eq({"name" => "USR0", 
                                                            "gpio" => 53, 
                                                            "led" => "usr0", 
                                                            "mux" => "gpmc_a5", 
                                                            "key" => "USR0", 
                                                            "muxRegOffset" => "0x054", 
                                                            "options" => ["gpmc_a5", "gmii2_txd0", "rgmii2_td0", "rmii2_txd0", "gpmc_a21", "pr1_mii1_rxd3", "eqep1b_in", "gpio1_21"]})

  end

end


