require 'bigdecimal'

module CurrentMeasurement
  class CurrentInputWithPoint04Shunt < CurrentInput

    def value
      # Conversion for 0.04 Ohm shunt resistance Breakout. 
      (BigDecimal(@analog_input.raw_value.to_s) / BigDecimal("0.04")).to_f
    end

  end
end