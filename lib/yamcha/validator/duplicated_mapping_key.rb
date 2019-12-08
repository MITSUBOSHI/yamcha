# frozen_string_literal: true

module Yamcha
  class Validator
    class DuplicatedMappingKey
      class Error < StandardError; end

      class << self
        def validate!(key_name:, hash:)
          raise Error.new("duplicated key `#{key_name}` exists") if hash.has_key?(key_name)
        end
      end
    end
  end
end
