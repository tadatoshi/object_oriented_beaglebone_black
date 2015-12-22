require 'bigdecimal'
require 'json'

module ObjectOrientedBeagleboneBlackExamples
  module UartConnectionToArduino
    class VoltageCurrentInput

      def initialize(uart_id, analog_steps, reference_voltage)
        @uart_connection = ObjectOrientedBeagleboneBlack::UartConnection.new(uart_id)
        @voltage_current_calculation = VoltageCurrentCalculation.new(analog_steps, reference_voltage)
      end

      def measure

        raw_data = @uart_connection.read(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: 'm')

        @raw_data_hash = JSON.parse(raw_data)

      end

      def input_voltage(higher_side_resistor_resistance: nil, lower_side_resistor_resistance: nil)

        if @raw_data_hash.has_key?("raw_reading_for_input_voltage")
          raw_reading_in_bigdecimal = BigDecimal(@raw_data_hash["raw_reading_for_input_voltage"].to_s)
          voltage_in_bigdecimal = @voltage_current_calculation.voltage(raw_reading_in_bigdecimal, 
                                                                       higher_side_resistor_resistance: higher_side_resistor_resistance, 
                                                                       lower_side_resistor_resistance: lower_side_resistor_resistance)
          voltage_in_bigdecimal.to_f
        end

      end

      def input_current(resistance_for_current_measurement: nil, voltage_gain_for_current_measurement: BigDecimal("1.0"), voltage_current_ratio_for_current_measurement: nil)

        if @raw_data_hash.has_key?("raw_reading_for_input_current")
          raw_reading_in_bigdecimal = BigDecimal(@raw_data_hash["raw_reading_for_input_current"].to_s)
          current_in_bigdecimal = @voltage_current_calculation.current(raw_reading_in_bigdecimal, 
                                                                       resistance_for_current_measurement: resistance_for_current_measurement, 
                                                                       voltage_gain_for_current_measurement: voltage_gain_for_current_measurement, 
                                                                       voltage_current_ratio_for_current_measurement: voltage_current_ratio_for_current_measurement)
          current_in_bigdecimal.to_f
        end

      end

      def output_voltage(higher_side_resistor_resistance: nil, lower_side_resistor_resistance: nil)

        if @raw_data_hash.has_key?("raw_reading_for_output_voltage")
          raw_reading_in_bigdecimal = BigDecimal(@raw_data_hash["raw_reading_for_output_voltage"].to_s)
          voltage_in_bigdecimal = @voltage_current_calculation.voltage(raw_reading_in_bigdecimal, 
                                                                       higher_side_resistor_resistance: higher_side_resistor_resistance, 
                                                                       lower_side_resistor_resistance: lower_side_resistor_resistance)
          voltage_in_bigdecimal.to_f
        end

      end

      def output_current(resistance_for_current_measurement: nil, voltage_gain_for_current_measurement: BigDecimal("1.0"), voltage_current_ratio_for_current_measurement: nil)

        if @raw_data_hash.has_key?("raw_reading_for_output_current")
          raw_reading_in_bigdecimal = BigDecimal(@raw_data_hash["raw_reading_for_output_current"].to_s)
          current_in_bigdecimal = @voltage_current_calculation.current(raw_reading_in_bigdecimal, 
                                                                       resistance_for_current_measurement: resistance_for_current_measurement, 
                                                                       voltage_gain_for_current_measurement: voltage_gain_for_current_measurement, 
                                                                       voltage_current_ratio_for_current_measurement: voltage_current_ratio_for_current_measurement)
          current_in_bigdecimal.to_f
        end

      end      
    
    end
  end
end