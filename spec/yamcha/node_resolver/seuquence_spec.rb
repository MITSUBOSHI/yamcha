# frozen_string_literal: true

RSpec.describe Yamcha::NodeResolver::Sequence do
  describe '#resolve' do
    subject { described_class.new(node: node).resolve }

    let(:node) { Psych::Nodes::Sequence.new }
    let(:values) { ['a', 'b', 'c'] }

    before do
      values.each do |value|
        node.children << Psych::Nodes::Scalar.new(value)
      end
    end

    it do
      is_expected.to be_a_kind_of Array
      is_expected.to eq values
    end
  end
end
