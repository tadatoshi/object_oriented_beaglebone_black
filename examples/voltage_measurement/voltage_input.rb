require 'bigdecimal'

module VoltageMeasurement
  class VoltageInput

    def initialize(pin_key)
      @analog_input = BeagleboneBlackRuby::AnalogInput.new(pin_key)
    end

    def value
      # For voltage divider 11:1, e.g. 51[kΩ] and 5.1[kΩ]. If another voltage divider is added, extract this code to subclass and make this class parent class. 
      (@analog_input.raw_value * BigDecimal("11")).to_f
    end

  end
end