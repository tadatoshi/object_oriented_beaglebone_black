require 'bigdecimal'

module CurrentMeasurement
  class CurrentInputWithPoint04Shunt < CurrentInput

    def value
      # Conversion for 0.04 Ohm shunt resistance Breakout. 
      (@analog_input.raw_value / BigDecimal("0.04")).to_f
    end

  end
end