require 'bigdecimal'

module ObjectOrientedBeagleboneBlackExamples
  module CurrentMeasurement
    class CurrentInput

      def initialize(pin_key, resistance_for_current_measurement: nil, voltage_gain_for_current_measurement: BigDecimal("1.0"), voltage_current_ratio_for_current_measurement: nil)
        @analog_input = ObjectOrientedBeagleboneBlack::AnalogInput.new(pin_key)

        @voltage_current_calculation = VoltageCurrentCalculation.new

        @resistance_for_current_measurement = resistance_for_current_measurement
        @voltage_gain_for_current_measurement = voltage_gain_for_current_measurement
        @voltage_current_ratio_for_current_measurement = voltage_current_ratio_for_current_measurement        
      end

      def value
        raw_analog_reading = BigDecimal(@analog_input.raw_value.to_s)

        current_in_bigdecimal = @voltage_current_calculation.current(raw_analog_reading, 
                                                                     resistance_for_current_measurement: @resistance_for_current_measurement, 
                                                                     voltage_gain_for_current_measurement: @voltage_gain_for_current_measurement, 
                                                                     voltage_current_ratio_for_current_measurement: @voltage_current_ratio_for_current_measurement)

        current_in_bigdecimal.to_f
      end

    end
  end
end