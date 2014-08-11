module BeagleboneBlackRuby
  class Gpio

    def initialize(pin_number)
      @pin_number = pin_number
      @gpio_directory = File.join(BEAGLEBONE_BLACK_RUBY_CONFIG["io_root_directory"], "gpio")
    end

    def export
      File.open(File.join(@gpio_directory, "export"), "w") { |file| file.write(@pin_number) }
    end

    def unexport
      File.open(File.join(@gpio_directory, "unexport"), "w") { |file| file.write(@pin_number) }
    end

    def direction=(direction)
      File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "direction"), "w") { |file| file.write(direction) }
    end

    def direction
      File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "direction"), "r").read
      # direction = nil
      # File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "direction"), "r") { |file| direction = file.read }
      # direction
    end

    def value=(value)
      File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "value"), "w") { |file| file.write(value) }
    end

    def value
      File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "value"), "r").read.to_i
      # value = nil
      # File.open(File.join(@gpio_directory, "gpio#{@pin_number}", "value"), "r") { |file| value = file.read.to_i }
      # value
    end

  end
end