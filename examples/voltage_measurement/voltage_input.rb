require 'bigdecimal'

module VoltageMeasurement
  class VoltageInput

    def initialize(pin_key)
      @analog_input = BeagleboneBlackRuby::AnalogInput.new(pin_key)
    end

    def value
      (@analog_input.raw_value * BigDecimal("11")).to_f
    end

  end
end