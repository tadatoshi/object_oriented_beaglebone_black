require 'json'
# require 'active_support/core_ext/hash/keys'

module ObjectOrientedBeagleboneBlack
  module UartMappings

    ID_TELETYPE_DEVICE_PATH_MAPPING = { "UART0" => "/dev/ttyO0", "UART1" => "/dev/ttyO1", "UART2" => "/dev/ttyO2", "UART3" => "/dev/ttyO3", "UART4" => "/dev/ttyO4", "UART5" => "/dev/ttyO5" }
    
    def load_uarts_array
      ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_UARTS_HASH ||= JSON.load(File.read(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT, "config", "uarts.json")))["uarts"]
    end

    def property_hash(id: nil)
      load_uarts_array

      uart_hash = {}

      if !id.nil?
        teletype_device_path = ID_TELETYPE_DEVICE_PATH_MAPPING[id]
        uart_hash = ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_UARTS_HASH[teletype_device_path]
        uart_hash["teletype_device_path"] = teletype_device_path
      end

      uart_hash

    end

  end
end