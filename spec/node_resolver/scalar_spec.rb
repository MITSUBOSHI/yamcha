# frozen_string_literal: true

RSpec.describe Yamcha::NodeResolver::Scalar do
  describe '#resolve' do
    subject { described_class.new(node: node).resolve }

    let(:node) { Psych::Nodes::Scalar.new(value) }
    let(:value) { 'example' }

    it do
      is_expected.to be_a_kind_of String
      is_expected.to eq value
    end
  end
end
