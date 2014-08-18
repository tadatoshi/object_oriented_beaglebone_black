require 'bigdecimal'

module BeagleboneBlackRuby
  class Pwm

    DUTY_VALUE_PER_ONE_HUNDREDTH = BigDecimal("5000")

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

    # duty_cycle (value between 0 and 1)
    def duty_cycle=(duty_cycle)
      internal_duty_value = (BigDecimal(duty_cycle.to_s) * BigDecimal("100") * DUTY_VALUE_PER_ONE_HUNDREDTH).to_i
      File.open(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "pwm_test_#{@pin_key}.15", "duty"), "w") { |file| file.write(internal_duty_value) }
    end

    def duty_cycle
      # Using this instead of simple "File.open(file_path).read" in order to close file after reading.
      internal_duty_value = nil
      File.open(File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "pwm_test_#{@pin_key}.15", "duty"), "r") { |file| internal_duty_value = file.read.strip }
      duty_cycle = (BigDecimal(internal_duty_value.to_s) / DUTY_VALUE_PER_ONE_HUNDREDTH / BigDecimal("100")).to_f
      duty_cycle
    end

  end
end