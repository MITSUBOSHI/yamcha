# frozen_string_literal: true

module Yamcha
  class Composer
    def initialize(node:, enable_validator: true)
      @node = node
      @enable_validator = enable_validator
      @hash = {}
    end

    def compose
      resolved_node = ::Yamcha::NodeResolver.resolve(@node)

      recursively_compose(resolved_node, @hash)
    end

    private
    
    def recursively_compose(resolved_node, hash)
      return resolved_node unless resolved_node.is_a? Array

      resolved_node.each_slice(2) do |node1, node2|
        resolved_node1 = ::Yamcha::NodeResolver.resolve(node1)
        resolved_node2 = ::Yamcha::NodeResolver.resolve(node2)

        if scalar_and_sequence?(node1, node2)
          hash = compose_hash(key: resolved_node1, value: resolved_node2, hash: hash)
        elsif scalar_and_mapping?(node1, node2)
          tmp_hash = {}
          result = recursively_compose(resolved_node2, tmp_hash)
          hash = compose_hash(key: resolved_node1, value: result, hash: hash)
        elsif scalar_and_saclar?(node1, node2)
          hash = compose_hash(key: resolved_node1, value: resolved_node2, hash: hash)
        else
          # noop
        end
      end
      hash
    end

    def compose_hash(key:, value:, hash:)
      ::Yamcha::Validator::DuplicatedMappingKey.validate!(key_name: key, hash: hash) if @enable_validator
      hash[key] = value
      hash
    end

    def scalar_and_sequence?(node1, node2)
      node1.is_a?(Psych::Nodes::Scalar) && node2.is_a?(Psych::Nodes::Sequence)
    end

    def scalar_and_mapping?(node1, node2)
      node1.is_a?(Psych::Nodes::Scalar) && node2.is_a?(Psych::Nodes::Mapping)
    end

    def scalar_and_saclar?(node1, node2)
      node1.is_a?(Psych::Nodes::Scalar) && node2.is_a?(Psych::Nodes::Scalar)
    end
  end
end
