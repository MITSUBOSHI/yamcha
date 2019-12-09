# frozen_string_literal: true

require "yamcha/node_resolver/base"
require "yamcha/node_resolver/document"
require "yamcha/node_resolver/mapping"
require "yamcha/node_resolver/scalar"
require "yamcha/node_resolver/sequence"

module Yamcha
  class NodeResolver
    class << self
      def resolve(node)
        new(node: node).resolve
      end
    end

    def initialize(node:)
      @node = node
    end

    def resolve
      resolver.resolve
    end

    def resolver
      case @node
      when Psych::Nodes::Document
        ::Yamcha::NodeResolver::Document.new(node: @node)
      when Psych::Nodes::Mapping
        ::Yamcha::NodeResolver::Mapping.new(node: @node)
      when Psych::Nodes::Sequence
        ::Yamcha::NodeResolver::Sequence.new(node: @node)
      when Psych::Nodes::Scalar
        ::Yamcha::NodeResolver::Scalar.new(node: @node)
      end
    end
  end
end
