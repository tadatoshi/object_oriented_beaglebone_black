require 'fileutils'

module BeagleboneBlackRuby
  class Led
    include BeagleboneBlackRuby::PinMappings
    include BeagleboneBlackRuby::IO

    LED_RELATIVE_DIRECTORY_PATTERN = "leds/beaglebone:green:%s"
    TRIGGER_FILENAME = "trigger"

    def initialize(led_name)
      @led_name = led_name
    end

    def pin_mode=(pin_mode)
      case pin_mode
      when "out"
        write_to_io_file(TRIGGER_FILENAME, "gpio")
      else
        raise "Invalid pin_mode for Led: #{pin_mode}. Must be 'out'"
      end
    end

    private
      def file_directory_path
        internal_led_name = property_hash(@led_name)[:led]
        File.join(BEAGLEBONE_BLACK_RUBY_CONFIG[:io_root_directory], sprintf(LED_RELATIVE_DIRECTORY_PATTERN, internal_led_name))
      end

  end
end