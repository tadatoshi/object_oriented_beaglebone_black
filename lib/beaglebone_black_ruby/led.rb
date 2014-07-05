module BeagleboneBlackRuby
  class Led
    include BeagleboneBlackRuby::PinMappings

    LED_RELATIVE_DIRECTORY_PATTERN = "leds/beaglebone:green:%s"

    def initialize(led_name)
      @led_name = led_name
    end

    

  end
end