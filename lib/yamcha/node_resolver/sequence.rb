# frozen_string_literal: true

module Yamcha
  class NodeResolver
    class Sequence < Base
      def resolve
        node.children.map(&:value)
      end
    end
  end
end
