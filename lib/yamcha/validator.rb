# frozen_string_literal: true

module Yamcha
  class Validator
    attr_reader :original_yaml

    def initialize(yaml_data)
      @original_yaml = yaml_data
    end

    def validate!(enable_validator: true)
      ::Yamcha::Composer.new(node: parsed_nodes, enable_validator: enable_validator).compose
    end

    private
    
    def parsed_nodes
      @parsed_nodes ||= YAML.parse(original_yaml)
    end
  end
end
