# frozen_string_literal: true

module Yamcha
  class NodeResolver
    class Mapping < Base
      def resolve
        node.children
      end
    end
  end
end
