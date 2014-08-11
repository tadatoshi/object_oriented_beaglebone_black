require 'spec_helper'
require 'fileutils'

describe BeagleboneBlackRuby::Gpio, gpio: true do

  before(:each) do
    @temp_gpio_directory = File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["io_root_directory"], "gpio")

    # In order to run this spec example in the real environment, the directories and files that already exist there are not created in that case. 
    if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'
      FileUtils.mkdir_p(@temp_gpio_directory, mode: 0700) unless Dir.exists?(@temp_gpio_directory)
      FileUtils.touch(File.join(@temp_gpio_directory, "export"))
      File.chmod(0700, File.join(@temp_gpio_directory, "export")) # Not same as the real one (with only write permission) but adding write permission as well just in case what is written there needs to be read. 
      FileUtils.touch(File.join(@temp_gpio_directory, "unexport"))
      File.chmod(0700, File.join(@temp_gpio_directory, "unexport")) # Not same as the real one (with only write permission) but adding write permission as well just in case what is written there needs to be read. 
    end
  end

  after(:each) do
    if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'
      File.open(File.join(@temp_gpio_directory, "export"), 'w') {|file| file.truncate(0) }
      File.open(File.join(@temp_gpio_directory, "unexport"), 'w') {|file| file.truncate(0) }
    end
  end

  describe "test with same circuit setting as boneDeviceTree gpio/TestApplication.cpp" do

    it "should blink LED's through GPIO defined by Device Tree Overlay" do

      led_gpio_pin_number = 60
      button_gpio_pin_number = 15

      led_gpio = BeagleboneBlackRuby::Gpio.new(led_gpio_pin_number)

      led_gpio.export
      # Since the real "export" file creates a directory structure when a pin number is written to it, 
      # in the "test" environment with a regular file, it is mimiced here.
      mimic_internal_export(led_gpio_pin_number) if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'

      expect(Dir.exists?(File.join(@temp_gpio_directory, "gpio#{led_gpio_pin_number}"))).to be true

      led_gpio.direction = BeagleboneBlackRuby::IO::Direction::OUT

      expect(led_gpio.direction).to eq(BeagleboneBlackRuby::IO::Direction::OUT)

      (0..1).each do |second|
        led_gpio.value = BeagleboneBlackRuby::IO::Value::HIGH
        expect(led_gpio.value).to eq(BeagleboneBlackRuby::IO::Value::HIGH)
        sleep(0.5)
        led_gpio.value = BeagleboneBlackRuby::IO::Value::LOW
        expect(led_gpio.value).to eq(BeagleboneBlackRuby::IO::Value::LOW)
        sleep(0.5)
      end

      led_gpio.unexport
      # Since the real "unexport" file deletes a directory structure when a pin number is written to it, 
      # in the "test" environment with a regular file, it is mimiced here.
      mimic_internal_unexport(led_gpio_pin_number) if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'

      expect(Dir.exists?(File.join(@temp_gpio_directory, "gpio#{led_gpio_pin_number}"))).to be false

    end

  end

end