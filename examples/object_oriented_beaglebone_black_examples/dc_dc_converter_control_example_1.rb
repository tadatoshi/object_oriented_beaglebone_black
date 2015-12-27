require 'object_oriented_beaglebone_black_examples'
require 'bigdecimal'

uart_id = "UART4"

uart_connection = ObjectOrientedBeagleboneBlack::UartConnection.new(uart_id)

# The parameters for Arduino Due:
analog_steps = BigDecimal("4095")
reference_voltage = BigDecimal("3.3")

voltage_current_input = ObjectOrientedBeagleboneBlackExamples::UartConnectionToArduino::VoltageCurrentInput.new(uart_connection, analog_steps, reference_voltage)

voltage_current_input.measure

# higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
input_voltage = voltage_current_input.input_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))
# shunt resistance: 0.04[Ω]
input_current = voltage_current_input.input_current(resistance_for_current_measurement: BigDecimal("0.04"))
# higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
output_voltage = voltage_current_input.output_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))    

puts "----- Before setting PWM -----"

puts "input_voltage: #{input_voltage}"
puts "input_current: #{input_current}"
puts "output_voltage: #{output_voltage}"

puts "output_voltage / input_voltage = #{(BigDecimal(output_voltage.to_s) / BigDecimal(input_voltage.to_s)).to_f}"

# The parameters for Arduino Due:
pwm_steps = BigDecimal("255")

pwm_output = ObjectOrientedBeagleboneBlackExamples::UartConnectionToArduino::PwmOutput.new(uart_connection, pwm_steps)

pwm_output.send(0.5)

voltage_current_input.measure

# higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
input_voltage = voltage_current_input.input_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))
# shunt resistance: 0.04[Ω]
input_current = voltage_current_input.input_current(resistance_for_current_measurement: BigDecimal("0.04"))
# higher_side_resistor_resistance: 100[kΩ], lower_side_resistor_resistance: 8.2[kΩ]
output_voltage = voltage_current_input.output_voltage(higher_side_resistor_resistance: BigDecimal("100000"), lower_side_resistor_resistance: BigDecimal("8200"))    

puts "----- After setting PWM -----"

puts "input_voltage: #{input_voltage}"
puts "input_current: #{input_current}"
puts "output_voltage: #{output_voltage}"

puts "output_voltage / input_voltage = #{(BigDecimal(output_voltage.to_s) / BigDecimal(input_voltage.to_s)).to_f}"

