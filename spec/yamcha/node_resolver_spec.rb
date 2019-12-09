# frozen_string_literal: true

RSpec.describe Yamcha::NodeResolver do
  describe ".resolve" do
    subject { described_class.resolve(node) }
    let(:node) { YAML.parse({a: 1}.to_yaml) }

    it do
      is_expected.to match(
        [
          include(a_kind_of(Psych::Nodes::Scalar)),
          include(a_kind_of(Psych::Nodes::Scalar)),
        ]
      )
    end
  end

  describe "#resolver" do
    subject { described_class.new(node: node).resolver }

    context "when node class is Psych::Nodes::Document" do
      let(:node) { Psych::Nodes::Document.new }
      it { is_expected.to be_a_kind_of Yamcha::NodeResolver::Document }
    end

    context "when node class is Psych::Nodes::Mapping" do
      let(:node) { Psych::Nodes::Mapping.new }
      it { is_expected.to be_a_kind_of Yamcha::NodeResolver::Mapping }
    end

    context "when node class is Psych::Nodes::Sequence" do
      let(:node) { Psych::Nodes::Sequence.new }
      it { is_expected.to be_a_kind_of Yamcha::NodeResolver::Sequence }
    end

    context "when node class is Psych::Nodes::Scalar" do
      let(:node) { Psych::Nodes::Scalar.new('example') }
      it { is_expected.to be_a_kind_of Yamcha::NodeResolver::Scalar }
    end
  end
end
