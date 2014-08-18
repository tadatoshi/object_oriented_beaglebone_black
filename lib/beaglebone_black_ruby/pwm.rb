module BeagleboneBlackRuby
  class Pwm

    def initialize(pin_key)
      @pin_key = pin_key
      @slots_file_path = File.join(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays
    end

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 
      File.open(@slots_file_path, "a") { |file| file.write("am33xx_pwm") }
      File.open(@slots_file_path, "a") { |file| file.write("bone_pwm_#{@pin_key}") }
    end

    def duty_cycle=(duty_cycle) 
      File.open(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "pwm_test_#{@pin_key}.15", "duty"), "w") { |file| file.write(duty_cycle) }
    end

    def duty_cycle
      # Using this instead of simple "File.open(file_path).read" in order to close file after reading.
      duty_cycle = nil
      File.open(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "pwm_test_#{@pin_key}.15", "duty"), "r") { |file| duty_cycle = file.read.strip.to_f }
      duty_cycle
    end

  end
end