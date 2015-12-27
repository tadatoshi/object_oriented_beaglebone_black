require 'bigdecimal'

module ObjectOrientedBeagleboneBlackExamples
  module UartConnectionToArduino
    class PwmOutput

      def initialize(uart_connection, pwm_steps)
        @uart_connection = uart_connection

        @pwm_steps = BigDecimal(pwm_steps.to_s)
      end

      def send(duty_cycle)

        duty_cycle_in_bigdecimal = BigDecimal(duty_cycle.to_s)
        raw_value = convert_duty_cycle(duty_cycle_in_bigdecimal)
        communication_command = "p#{raw_value}"

        @uart_connection.write(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: communication_command)

      end  

      private
        def convert_duty_cycle(duty_cycle_in_bigdecimal)
          (duty_cycle_in_bigdecimal * @pwm_steps).to_i
        end  
    
    end
  end
end