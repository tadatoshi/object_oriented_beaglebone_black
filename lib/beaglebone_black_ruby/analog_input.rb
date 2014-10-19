require 'bigdecimal'

module BeagleboneBlackRuby
  class AnalogInput
    include BeagleboneBlackRuby::PinMappings

    def initialize(pin_key)
      @pin_key = pin_key
      @slots_file_path = File.join(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays      
    end 

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 
      File.open(@slots_file_path, "a") { |file| file.write("cape-bone-iio") }
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
        Dir["#{File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "helper.")}*"].first
      end

  end
end