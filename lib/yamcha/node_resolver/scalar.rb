# frozen_string_literal: true

module Yamcha
  class NodeResolver
    class Scalar < Base
      def resolve
        node.value
      end
    end
  end
end
