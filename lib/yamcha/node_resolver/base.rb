# frozen_string_literal: true

module Yamcha
  class NodeResolver
    class Base
      attr_reader :node

      def initialize(node:)
        @node = node
      end

      def resolve
        raise NotImplementedError
      end
    end
  end
end
