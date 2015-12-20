require 'bigdecimal'

module ObjectOrientedBeagleboneBlack
  class AnalogInput
    include ObjectOrientedBeagleboneBlack::PinMappings

    ANALOG_INPUT_DEVICE_TREE_OVERLAY_PARAMETER = "cape-bone-iio"

    def initialize(pin_key)
      @pin_key = pin_key
      @slots_file_path = File.join(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays      
    end 

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 

      puts "This can take a few seconds for necessary setups..."

      slots_file = File.open(@slots_file_path, "a+")
      slots_file_content = slots_file.read

      unless slots_file_content.include? ANALOG_INPUT_DEVICE_TREE_OVERLAY_PARAMETER
      # until slots_file_content.include? ANALOG_INPUT_DEVICE_TREE_OVERLAY_PARAMETER

        # Just in case where the previous read operation is not fully terminated.
        sleep 1

        slots_file.write(ANALOG_INPUT_DEVICE_TREE_OVERLAY_PARAMETER)

        # Just in case where it takes time to load device tree overlay.
        sleep 1

        # Note: Sometime, the file pointer seems to be at the end of the file and doesn't read the file content before that.
        # slots_file_content = slots_file.read
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

    def raw_value
      internal_raw_value = nil
      File.open(File.join(analog_input_directory, pin_name(@pin_key)), "r") { |file| internal_raw_value = file.read.strip }
      raw_value = (BigDecimal(internal_raw_value.to_s) / BigDecimal("1000")).to_f
      raw_value
    end

    def value
      # The raw_value is in the range of 0 to 1.8[V]. 
      # The value is in the range of 0 to 1.0. 
      (BigDecimal(raw_value.to_s) * (BigDecimal("1.0") / BigDecimal("1.8"))).to_f
    end

    private
      def pin_name(pin_key)
        property_hash(key: pin_key)["name"]
      end

      def analog_input_directory
        Dir["#{File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"], "helper.")}*"].first
      end

  end
end