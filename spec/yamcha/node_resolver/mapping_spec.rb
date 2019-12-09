# frozen_string_literal: true

RSpec.describe Yamcha::NodeResolver::Mapping do
  describe '#resolve' do
    subject { described_class.new(node: node).resolve }

    let(:node) { Psych::Nodes::Mapping.new }
    before { node.children << Psych::Nodes::Scalar.new('example') }

    it { is_expected.to be_a_kind_of Array }
  end
end
