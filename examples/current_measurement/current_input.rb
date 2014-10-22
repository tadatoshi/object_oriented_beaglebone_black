require 'bigdecimal'

module CurrentMeasurement
  class CurrentInput

    def initialize(pin_key)
      @analog_input = BeagleboneBlackRuby::AnalogInput.new(pin_key)
    end

    def value
      # Conversion for ACS712 Breakout. If a different current measurement device is used, extract this code to subclass and make this class parent class.
      (@analog_input.raw_value / BigDecimal("0.185")).to_f
    end

  end
end