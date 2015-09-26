require 'fileutils'

module PwmFileBehaviorHelper

  # In Embedded Linux, when a Device Tree Overlay for the specific PWM PIN key is activated, 
  # a directory with the name including the pin key is created with the various files e.g. duty, etc. underneath the directory. 
  # This method is for performing that automatic behavior in the local test environment. 
  def mimic_internal_pwm_directory_creation(pwm_pin_key)
    temp_specific_pwm_directory = File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_CONFIG["device_directory"], "pwm_test_#{pwm_pin_key}.15")

    unless Dir.exists?(temp_specific_pwm_directory)
      FileUtils.mkdir_p(temp_specific_pwm_directory, mode: 0700)
    end

    # "period" must be set to the default value, because duty value is relative to it:
    FileUtils.touch(File.join(temp_specific_pwm_directory, "period"))
    File.chmod(0700, File.join(temp_specific_pwm_directory, "period"))
    File.open(File.join(temp_specific_pwm_directory, "period"), 'w') {|file| file.write(500000) }

    unless Dir.exists?(temp_specific_pwm_directory)  
      FileUtils.touch(File.join(temp_specific_pwm_directory, "duty"))
      File.chmod(0700, File.join(temp_specific_pwm_directory, "duty"))
      File.open(File.join(temp_specific_pwm_directory, "duty"), 'w') {|file| file.write(250000) }
      FileUtils.touch(File.join(temp_specific_pwm_directory, "polarity"))
      File.chmod(0700, File.join(temp_specific_pwm_directory, "polarity"))
      File.open(File.join(temp_specific_pwm_directory, "polarity"), 'w') {|file| file.write(ObjectOrientedBeagleboneBlack::Pwm::Polarity::INVERSE) }      
    end
  end

end