require 'serialport'

module ObjectOrientedBeagleboneBlack
  class UartConnection
    include ObjectOrientedBeagleboneBlack::UartMappings

    PARITY = SerialPort::NONE

    def initialize(uart_id)
      @uart_id = uart_id
      @slots_file_path = File.join(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays      
    end 

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 

      puts "This can take a few seconds for necessary setups..."

      slots_file = File.open(@slots_file_path, "a+")
      slots_file_content = slots_file.read

      unless slots_file_content.include? device_tree_overlay_parameter

        # Just in case where the previous read operation is not fully terminated.
        sleep 1

        slots_file.write(device_tree_overlay_parameter)

        # Just in case where it takes time to load device tree overlay.
        sleep 1

      end

      # Note: Closing this file sometimes causes an error in BeagleBone Black:
      #       Errno::EEXIST: File exists @ fptr_finalize - /sys/devices/bone_capemgr.9/slots
      begin
        slots_file.close if File.exist?(@slots_file_path) && !slots_file.closed?
      rescue SystemCallError => system_call_error_message
        puts "Error happened while closing #{@slots_file_path} with the message: #{system_call_error_message}"
      end

      puts "Setups done."

    end

    def read(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: 's')

      data = nil

      SerialPort.open(teletype_device_path, 
                      serial_baud_rate, 
                      serial_data_bits, 
                      serial_stop_bits, 
                      PARITY) do |serial_port|
        serial_port.sync = true

        serial_port.putc(communication_command)

        data = serial_port.gets
      end   

      data.strip

    end

    def write(serial_baud_rate: 9600, serial_data_bits: 8, serial_stop_bits: 1, communication_command: 's')

      data = nil

      SerialPort.open(teletype_device_path, 
                      serial_baud_rate, 
                      serial_data_bits, 
                      serial_stop_bits, 
                      PARITY) do |serial_port|
        serial_port.sync = true

        serial_port.puts(communication_command)
      end

    end    

    private
      def device_tree_overlay_parameter
        @device_tree_overlay_parameter ||= property_hash(id: @uart_id)["devicetree"]
      end

      def teletype_device_path
        @teletype_device_path ||= property_hash(id: @uart_id)["teletype_device_path"]
      end

  end
end