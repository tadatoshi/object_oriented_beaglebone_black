require 'spec_helper'
require 'fileutils'

describe BeagleboneBlackRuby::Pwm, pwm: true do

  before(:each) do

    @slots_directory = BEAGLEBONE_BLACK_RUBY_CONFIG["slots_directory"]
    @device_directory = BEAGLEBONE_BLACK_RUBY_CONFIG["device_directory"]

    # In order to run this spec example in the real environment, the directories and files that already exist there are not created in that case. 
    if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'
      FileUtils.mkdir_p(@slots_directory, mode: 0700) unless Dir.exists?(@slots_directory)
      FileUtils.touch(File.join(@slots_directory, "slots"))
      File.chmod(0700, File.join(@slots_directory, "slots"))

      FileUtils.mkdir_p(@device_directory, mode: 0700) unless Dir.exists?(@device_directory)         
    end
  end

  after(:each) do
    if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'
      File.open(File.join(@slots_directory, "slots"), 'w') {|file| file.truncate(0) }
    end
  end

  describe "test with same setting as in https://learn.adafruit.com/setting-up-io-python-library-on-beaglebone-black/pwm" do

    it "should duty cycle" do

      pwm_pin_key = "P9_14"

      pwm = BeagleboneBlackRuby::Pwm.new(pwm_pin_key)

      # Since the real "slots" file creates a directory structure when a device tree overlay is written to it, 
      # in the "test" environment with a regular file, it is mimiced here.
      mimic_internal_pwm_directory_creation(pwm_pin_key) if ENV["BEAGLEBONE_BLACK_RUBY_ENV"] == 'test'

      expect(Dir.exists?(File.join(@device_directory, "pwm_test_#{pwm_pin_key}.15"))).to be true

      pwm.duty_cycle = 0.5

      expect(pwm.polarity).to eq(BeagleboneBlackRuby::Pwm::Polarity::DIRECT)
      expect(pwm.duty_cycle).to eq(0.5)

      sleep(2)

      pwm.duty_cycle = 0.225

      expect(pwm.polarity).to eq(BeagleboneBlackRuby::Pwm::Polarity::DIRECT)
      expect(pwm.duty_cycle).to eq(0.225)

    end

  end

end