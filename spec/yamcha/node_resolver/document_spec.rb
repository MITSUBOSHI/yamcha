# frozen_string_literal: true

RSpec.describe Yamcha::NodeResolver::Document do
  describe '#resolve' do
    subject { described_class.new(node: node).resolve }

    let(:node) { Psych::Nodes::Document.new }
    before { node.children << Psych::Nodes::Mapping.new }

    it { is_expected.to be_a_kind_of Array }
  end
end
