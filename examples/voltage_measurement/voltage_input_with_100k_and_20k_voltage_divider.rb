require 'bigdecimal'

module VoltageMeasurement
  class VoltageInputWith100kAnd20kVoltageDivider < VoltageInput

    def value
      # For voltage divider 6:1, e.g. 100[kΩ] and 20[kΩ]. 
      (@analog_input.raw_value * BigDecimal("6")).to_f
    end

  end
end