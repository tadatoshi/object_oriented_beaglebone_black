require 'json'
# require 'active_support/core_ext/hash/keys'

module BeagleboneBlackRuby
  module PinMappings
    
    def load_pin_index_array
      # In order not to use activesupport (since Beaglebone Black that is used currently doesn't have Internet access to download it), Hash#deep_symbolize_keys! is not used.
      # ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY ||= JSON.load(File.read(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, "config", "pin_index.json")))["pinIndex"].each { |property_hash| property_hash.deep_symbolize_keys! }
      ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY ||= JSON.load(File.read(File.join(BEAGLEBONE_BLACK_RUBY_ROOT, "config", "pin_index.json")))["pinIndex"]
    end

    def property_hash(name: nil, key: nil)
      load_pin_index_array

      if !name.nil?
        ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY.select { |property_hash| property_hash["name"] == name }.first
      elsif !key.nil?
        ::BEAGLEBONE_BLACK_RUBY_PIN_INDEX_ARRAY.select { |property_hash| property_hash["key"] == key }.first
      end

    end

  end
end