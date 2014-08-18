require 'fileutils'

module GpioFileBehaviorHelper

  # In Embedded Linux, when a GPIO pin number is written to /sys/class/gpio/export file, 
  # a directory with the name including the pin number is created with the various files e.g. direction, value, etc. underneath the directory. 
  # This method is for performing that automatic behavior in the local test environment. 
  def mimic_internal_export(gpio_pin_number)
    temp_specific_gpio_directory = File.join(temp_gpio_directory, "gpio#{gpio_pin_number}")

    unless Dir.exists?(temp_specific_gpio_directory)
      FileUtils.mkdir_p(temp_specific_gpio_directory, mode: 0700)

      FileUtils.touch(File.join(temp_specific_gpio_directory, "direction"))
      File.chmod(0700, File.join(temp_specific_gpio_directory, "direction")) # Not same as the real one but I prefer for a file to have only a user permission
      File.open(File.join(temp_specific_gpio_directory, "direction"), "w") { |file| file.write(BeagleboneBlackRuby::IO::Direction::IN) }
      
      FileUtils.touch(File.join(temp_specific_gpio_directory, "value"))
      File.chmod(0700, File.join(temp_specific_gpio_directory, "value")) # Not same as the real one but I prefer for a file to have only a user permission
      File.open(File.join(temp_specific_gpio_directory, "value"), "w") { |file| file.write(BeagleboneBlackRuby::IO::Value::LOW) }
    end

  end

  def mimic_internal_unexport(gpio_pin_number)
    temp_specific_gpio_directory = File.join(temp_gpio_directory, "gpio#{gpio_pin_number}")

    FileUtils.rm_rf(temp_specific_gpio_directory)
  end

  private
    def temp_gpio_directory
      File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["io_root_directory"], "gpio")
    end

end