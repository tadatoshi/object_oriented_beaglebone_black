require 'bigdecimal'

module ObjectOrientedBeagleboneBlack
  class Pwm

    PWM_DEVICE_TREE_OVERLAY_PARAMETER = "am33xx_pwm"

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

      puts "This can take several seconds for necessary setups..."

      slots_file = File.open(@slots_file_path, "a+")
      slots_file_content = slots_file.read

      unless slots_file_content.include? PWM_DEVICE_TREE_OVERLAY_PARAMETER
      # until slots_file_content.include? PWM_DEVICE_TREE_OVERLAY_PARAMETER

        # Just in case where the previous read session is not fully completed.
        sleep 1

        slots_file.write(PWM_DEVICE_TREE_OVERLAY_PARAMETER)

        # It seems to take a time to load the device tree overlay. Wait for two seconds.
        sleep 2

        # Note: Sometime, the file pointer seems to be at the end of the file and doesn't read the file content before that. 
        # slots_file_content = slots_file.read

      end

      # Note: Closing this file sometimes causes an error in BeagleBone Black:
      #   Errno::ENOENT: No such file or directory @ fptr_finalize - /sys/devices/bone_capemgr.9/slots
      begin
        slots_file.close if File.exist?(@slots_file_path) && !slots_file.closed?
      rescue SystemCallError => system_call_error_message
        puts "Error happened while closing #{@slots_file_path} with the message: #{system_call_error_message}"
      end

      # Just in case
      sleep 1

      puts "First step of setups done."

      pwm_pin_device_tree_overlay_parameter = "bone_pwm_#{@pin_key}"

      slots_file = File.open(@slots_file_path, "a+")
      slots_file_content = slots_file.read

      unless slots_file_content.include? pwm_pin_device_tree_overlay_parameter
      # until slots_file_content.include? pwm_pin_device_tree_overlay_parameter

        # Just in case where the previous read session is not fully completed.
        sleep 1

        slots_file.write(pwm_pin_device_tree_overlay_parameter)

        # It seems to take a time to load the device tree overlay. Wait for one second.
        sleep 2

        # Note: Sometime, the file pointer seems to be at the end of the file and doesn't read the file content before that.
        # slots_file_content = slots_file.read

      end

      # Note: Closing this file sometimes causes an error in BeagleBone Black:
      #   Errno::ENOENT: No such file or directory @ fptr_finalize - /sys/devices/bone_capemgr.9/slots
      begin
        slots_file.close if File.exist?(@slots_file_path) && !slots_file.closed?
      rescue SystemCallError => system_call_error_message
        puts "Error happened while closing #{@slots_file_path} with the message: #{system_call_error_message}"
      end

      puts "Setups done."

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
      current_duty_cycle = self.duty_cycle

      File.open(File.join(pwm_directory, "period"), "w") { |file| file.write(period) }
      
      # Preserves the duty cycle:
      # Note: Internally in BeagleBone Black, "duty" value is relative to "period" value. 
      #       e.g. For "period" = 1000, "duty" = 500 gives the duty cycle = 500 / 1000 = 0.5.
      self.duty_cycle = current_duty_cycle
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