require 'fileutils'
require 'bigdecimal'

module AnalogInputFileBehaviorHelper
  include BeagleboneBlackRuby::PinMappings

  # In Embedded Linux, when a Device Tree Overlay for the specific Analog input PIN key is activated, 
  # a directory with the name including the pin key is created with the various files e.g. AIN0, etc. underneath the directory. 
  # This method is for performing that automatic behavior in the local test environment. 
  def mimic_internal_analog_input_directory_creation(pin_key, raw_value)
    temp_specific_analog_input_directory = File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"], "helper.16")

    unless Dir.exists?(temp_specific_analog_input_directory)
      FileUtils.mkdir_p(temp_specific_analog_input_directory, mode: 0700)

      for ain_file_index in 0..7
        create_ain_file(temp_specific_analog_input_directory, ain_file_index)
      end
    end

    pin_name = property_hash(key: pin_key)["name"]
    converted_raw_value = (BigDecimal(raw_value.to_s) * BigDecimal("1000")).to_i
    File.open(File.join(temp_specific_analog_input_directory, pin_name), 'w') {|file| file.write(converted_raw_value) }

  end

  private
    def create_ain_file(temp_specific_analog_input_directory, ain_file_index)
      FileUtils.touch(File.join(temp_specific_analog_input_directory, "AIN#{ain_file_index}"))
      File.chmod(0700, File.join(temp_specific_analog_input_directory, "AIN#{ain_file_index}"))
      File.open(File.join(temp_specific_analog_input_directory, "AIN#{ain_file_index}"), 'w') {|file| file.write(1630) }
    end

end