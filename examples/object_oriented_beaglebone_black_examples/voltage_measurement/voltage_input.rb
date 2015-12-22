require 'bigdecimal'

module ObjectOrientedBeagleboneBlackExamples
  module VoltageMeasurement
    class VoltageInput

      def initialize(pin_key, higher_side_resistor_resistance: nil, lower_side_resistor_resistance: nil)
        @analog_input = ObjectOrientedBeagleboneBlack::AnalogInput.new(pin_key)

        @voltage_current_calculation = VoltageCurrentCalculation.new
        @higher_side_resistor_resistance = higher_side_resistor_resistance
        @lower_side_resistor_resistance = lower_side_resistor_resistance
      end

      def value
        raw_analog_reading = BigDecimal(@analog_input.raw_value.to_s)
        voltage_in_bigdecimal = @voltage_current_calculation.voltage(raw_analog_reading, 
                                                                     higher_side_resistor_resistance: @higher_side_resistor_resistance, 
                                                                     lower_side_resistor_resistance: @lower_side_resistor_resistance)

        voltage_in_bigdecimal.to_f
      end

    end
  end
end