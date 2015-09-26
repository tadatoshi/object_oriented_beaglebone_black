require 'bigdecimal'

module ObjectOrientedBeagleboneBlack
  class Pwm

    module Polarity
      DIRECT = 0
      INVERSE = 1
    end    

    def initialize(pin_key)
      @pin_key = pin_key
      @slots_file_path = File.join(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["slots_directory"], "slots"))

      activate_device_tree_overlays
    end

    def activate_device_tree_overlays
      # Note: Since slots file acts as an interface to activate Device Tree Overlay, simply writing to it does what needs to be done. 
      #       I'm using appending here so that testing in a local environment becomes straightfoward. 
      File.open(@slots_file_path, "a") do |file| 
        file.write("am33xx_pwm")
        file.write("bone_pwm_#{@pin_key}")
      end
    end

    # duty_cycle (value between 0 and 1)
    def duty_cycle=(duty_cycle)
      self.polarity = ObjectOrientedBeagleboneBlack::Pwm::Polarity::DIRECT
      internal_duty_value = (BigDecimal(duty_cycle.to_s) * BigDecimal(period.to_s)).to_i
      File.open(File.join(pwm_directory, "duty"), "w") { |file| file.write(internal_duty_value) }
    end

    def duty_cycle
      # Using this instead of simple "File.open(file_path).read" in order to close file after reading.
      internal_duty_value = nil
      File.open(File.join(pwm_directory, "duty"), "r") { |file| internal_duty_value = file.read.strip }
      duty_cycle = (BigDecimal(internal_duty_value.to_s) / BigDecimal(period.to_s)).to_f
      duty_cycle
    end

    def polarity=(polarity)
      File.open(File.join(pwm_directory, "polarity"), "w") { |file| file.write(polarity) }
    end

    def polarity
      internal_polarity_value = nil
      File.open(File.join(pwm_directory, "polarity"), "r") { |file| internal_polarity_value = file.read.strip.to_i }
      internal_polarity_value
    end

    def period=(period)
      File.open(File.join(pwm_directory, "period"), "w") { |file| file.write(period) }
    end

    # Unit: [ns] (nano second)
    def period
      internal_period_value = nil
      File.open(File.join(pwm_directory, "period"), "r") { |file| internal_period_value = file.read.strip.to_i }
      internal_period_value
    end

    private
      def pwm_directory
        Dir["#{File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"], "pwm_test_#{@pin_key}.")}*"].first
      end    

  end
end