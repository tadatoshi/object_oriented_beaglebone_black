require 'bigdecimal'

module VoltageMeasurement
  class VoltageInput

    def initialize(pin_key)
      @analog_input = ObjectOrientedBeagleboneBlack::AnalogInput.new(pin_key)
    end

    def value
      # For voltage divider 11:1, e.g. 51[kΩ] and 5.1[kΩ]. If another voltage divider is added, extract this code to subclass and make this class parent class. 
      (BigDecimal(@analog_input.raw_value.to_s) * BigDecimal("11")).to_f
    end

  end
end