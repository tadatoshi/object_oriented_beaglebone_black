require 'bigdecimal'

module ObjectOrientedBeagleboneBlack
  class AnalogInput
    include ObjectOrientedBeagleboneBlack::PinMappings

    def initialize(pin_key)
      @pin_key = pin_key
      @slots_file_path = File.join(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays      
    end 

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 
      # Note: Closing this file caused an error in BeagleBone Black:
      #       Errno::EEXIST: File exists @ fptr_finalize - /sys/devices/bone_capemgr.9/slots
      #       So modified the code not to close the file. 
      # File.open(@slots_file_path, "a") { |file| file.write("cape-bone-iio") }
      File.open(@slots_file_path, "a").write("cape-bone-iio")
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