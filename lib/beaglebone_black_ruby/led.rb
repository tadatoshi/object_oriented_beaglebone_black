require 'fileutils'

module BeagleboneBlackRuby
  class Led
    include BeagleboneBlackRuby::PinMappings

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
      def write_to_io_file(filename, value)
        internal_led_name = property_hash(@led_name)[:led]
        file_directory_path = File.join(BEAGLEBONE_BLACK_RUBY_CONFIG[:io_root_directory], sprintf(LED_RELATIVE_DIRECTORY_PATTERN, internal_led_name))
        FileUtils.mkdir_p(file_directory_path, mode: 0700) unless Dir.exists?(file_directory_path)
        file_path = File.join(file_directory_path, filename)
        
        open(file_path, "w").write(value) 
      end

  end
end