require 'json'
# require 'active_support/core_ext/hash/keys'

module ObjectOrientedBeagleboneBlack
  module PinMappings
    
    def load_pin_index_array
      # In order not to use activesupport (since Beaglebone Black didn't have Internet access to download it previously), Hash#deep_symbolize_keys! is not used.
      # ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_PIN_INDEX_ARRAY ||= JSON.load(File.read(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT, "config", "pin_index.json")))["pinIndex"].each { |property_hash| property_hash.deep_symbolize_keys! }
      ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_PIN_INDEX_ARRAY ||= JSON.load(File.read(File.join(OBJECT_ORIENTED_BEAGLEBONE_BLACK_ROOT, "config", "pin_index.json")))["pinIndex"]
    end

    def property_hash(name: nil, key: nil)
      load_pin_index_array

      if !name.nil?
        ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_PIN_INDEX_ARRAY.find { |property_hash| property_hash["name"] == name }
      elsif !key.nil?
        ::OBJECT_ORIENTED_BEAGLEBONE_BLACK_PIN_INDEX_ARRAY.find { |property_hash| property_hash["key"] == key }
      end

    end

  end
end