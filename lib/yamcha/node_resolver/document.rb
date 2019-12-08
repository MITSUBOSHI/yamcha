# frozen_string_literal: true

module Yamcha
  class NodeResolver
    class Document < Base
      def resolve
        node.root.children
      end
    end
  end
end
