require 'json'
require 'active_support/core_ext/hash/keys'

module BeagleboneBlackRuby
  module PinMappings
    
    def load_pin_index_array
      ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY ||= JSON.load(File.read(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, "config", "pin_index.json")))["pinIndex"].each { |property_hash| property_hash.deep_symbolize_keys! }
    end

    def property_hash(name)
      load_pin_index_array

      ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY.select { |property_hash| property_hash[:name] == name }.first
    end

  end
end