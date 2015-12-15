require 'bigdecimal'

module VoltageMeasurement
  class VoltageInputWith100kAnd11kVoltageDivider < VoltageInput

    def value
      # For voltage divider about 10:1, e.g. 100[kΩ] and 11[kΩ]. 
      (BigDecimal(@analog_input.raw_value.to_s) * (BigDecimal("111") / BigDecimal("11"))).to_f
    end

  end
end