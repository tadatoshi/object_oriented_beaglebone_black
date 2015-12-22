require 'spec_helper'
require 'bigdecimal'

describe ObjectOrientedBeagleboneBlackExamples::VoltageCurrentCalculation do

  context "External analog digital converter (Arduino)" do

    before(:each) do
      @analog_steps = BigDecimal("1023")
      reference_voltage = BigDecimal("5")
      @voltage_current_calculation = ObjectOrientedBeagleboneBlackExamples::VoltageCurrentCalculation.new(@analog_steps, reference_voltage)
    end

    context "voltage" do
    
      it "should calculate voltage based on the raw analog data" do

        raw_analog_reading = BigDecimal("1023")
        expect(@voltage_current_calculation.voltage(raw_analog_reading)).to be_within(BigDecimal("0.1")).of(BigDecimal("5.0"))

        raw_analog_reading = BigDecimal("511")
        expect(@voltage_current_calculation.voltage(raw_analog_reading)).to be_within(BigDecimal("0.1")).of(BigDecimal("2.5"))

      end

      it "should calculate voltage based on the raw analog data with voltage divisor" do

        raw_analog_reading = BigDecimal("1023")
        expect(@voltage_current_calculation.voltage(raw_analog_reading, 
                                                    higher_side_resistor_resistance: BigDecimal("1000"), 
                                                    lower_side_resistor_resistance: BigDecimal("1000"))).to be_within(BigDecimal("0.1")).of(BigDecimal("10.0"))           

        raw_analog_reading = BigDecimal("511")
        expect(@voltage_current_calculation.voltage(raw_analog_reading, 
                                                    higher_side_resistor_resistance: BigDecimal("1000"), 
                                                    lower_side_resistor_resistance: BigDecimal("1000"))).to be_within(BigDecimal("0.1")).of(BigDecimal("5.0"))      

        raw_analog_reading = BigDecimal("1023")
        expect(@voltage_current_calculation.voltage(raw_analog_reading, 
                                                    higher_side_resistor_resistance: BigDecimal("10"), 
                                                    lower_side_resistor_resistance: BigDecimal("2.2"))).to be_within(BigDecimal("0.1")).of(BigDecimal("27.7"))            

      end

      context "voltage divider" do

        it "should calculate resistor factor" do

          higher_side_resistor_resistance = BigDecimal("1000")
          lower_side_resistor_resistance = BigDecimal("1000")

          expect(@voltage_current_calculation.resistor_factor(higher_side_resistor_resistance, 
                                                              lower_side_resistor_resistance))
                                                             .to eq(@analog_steps * BigDecimal("0.5"))

          higher_side_resistor_resistance = BigDecimal("10")
          lower_side_resistor_resistance = BigDecimal("2.2")

          expect(@voltage_current_calculation.resistor_factor(higher_side_resistor_resistance, 
                                                              lower_side_resistor_resistance))
                                                             .to be_within(BigDecimal("1"))
                                                             .of(@analog_steps * BigDecimal("0.18"))

        end

        it "should get analog steps as resistor factor if the resistances are nil" do

          higher_side_resistor_resistance = nil
          lower_side_resistor_resistance = nil

          expect(@voltage_current_calculation.resistor_factor(higher_side_resistor_resistance, 
                                                              lower_side_resistor_resistance))
                                                             .to eq(@analog_steps * BigDecimal("1")) 

        end

      end

    end

    context "current" do

      it "should calculate current based on the raw analog voltage accross shunt resistance" do

        resistance_for_current_measurement = BigDecimal("0.005")
        voltage_gain_for_current_measurement = BigDecimal("100")      

        raw_analog_reading = BigDecimal("1023")
        expect(@voltage_current_calculation.current(raw_analog_reading, 
                                                    resistance_for_current_measurement: resistance_for_current_measurement, 
                                                    voltage_gain_for_current_measurement: voltage_gain_for_current_measurement)).to be_within(BigDecimal("0.1")).of(BigDecimal("10.0"))

        raw_analog_reading = BigDecimal("511")
        expect(@voltage_current_calculation.current(raw_analog_reading, 
                                                    resistance_for_current_measurement: resistance_for_current_measurement, 
                                                    voltage_gain_for_current_measurement: voltage_gain_for_current_measurement)).to be_within(BigDecimal("0.1")).of(BigDecimal("5.0"))

      end    

    end

  end

  context "Internal analog digital converter" do

    before(:each) do
      @voltage_current_calculation = ObjectOrientedBeagleboneBlackExamples::VoltageCurrentCalculation.new
    end

    context "current" do

      it "should calculate current based on the voltage measured by current sensor" do

        voltage_current_ratio_for_current_measurement = BigDecimal("0.185") # 185 [mV/A] for ACS712

        raw_analog_reading = BigDecimal("0.5")
        expect(@voltage_current_calculation.current(raw_analog_reading, 
                                                    voltage_current_ratio_for_current_measurement: voltage_current_ratio_for_current_measurement)).to be_within(BigDecimal("0.1")).of(BigDecimal("2.7"))

      end

    end

  end

end
