require "bigdecimal"

module ObjectOrientedBeagleboneBlackExamples
  class VoltageCurrentCalculation

    # The default value is for Analog Input pin of BeagleBone Black. 
    # Since Analog Input pin reading doesn't work when it's used with PWM, 
    # this class is created to accommodate the case where external analog digital converter is used. 
    # e.g. Analog input pin of Arduino. 
    def initialize(analog_steps = BigDecimal("1.8"), reference_voltage = BigDecimal("1.8"))
      @analog_steps = analog_steps
      @reference_voltage = reference_voltage
    end

    def voltage(raw_analog_reading, higher_side_resistor_resistance: nil, lower_side_resistor_resistance: nil)
     
      (raw_analog_reading / resistor_factor(higher_side_resistor_resistance, lower_side_resistor_resistance)) * @reference_voltage

    end

    def current(raw_analog_reading, resistance_for_current_measurement: nil, voltage_gain_for_current_measurement: BigDecimal("1.0"), voltage_current_ratio_for_current_measurement: nil)

      current = nil

      voltage = voltage(raw_analog_reading)

      if !resistance_for_current_measurement.nil? && voltage_current_ratio_for_current_measurement.nil? # The case where voltage accross shunt resistance is directly measured
        voltage = voltage / voltage_gain_for_current_measurement
        current = voltage / resistance_for_current_measurement
      elsif resistance_for_current_measurement.nil? && !voltage_current_ratio_for_current_measurement.nil? # The case where current sensor circuit is used
        current = voltage / voltage_current_ratio_for_current_measurement
      end

      current

    end

    def resistor_factor(higher_side_resistor_resistance, lower_side_resistor_resistance)

      if higher_side_resistor_resistance.nil? && lower_side_resistor_resistance.nil?
        @analog_steps
      else
        @analog_steps * (lower_side_resistor_resistance / (higher_side_resistor_resistance + lower_side_resistor_resistance))
      end

    end

  end
end