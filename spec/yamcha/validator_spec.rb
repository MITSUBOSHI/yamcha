# frozen_string_literal: true

RSpec.describe Yamcha::Validator do
  describe '#original_yaml' do
    subject { described_class.new(yaml).original_yaml }

    let(:yaml) do
      <<~YAML
      ---
      a: 1
      YAML
    end

    it { is_expected.to eq yaml }
  end

  describe 'private #parsed_nodes' do
    subject { described_class.new(yaml).__send__(:parsed_nodes) }

    let(:yaml) do
      <<~YAML
      ---
      a: 1
      YAML
    end
    let(:parsed_nodes) { YAML.parse(yaml) }

    before { allow(YAML).to receive(:parse).and_return(parsed_nodes) }

    it { is_expected.to eq parsed_nodes }
  end

  describe '#validate!' do
    subject { described_class.new(yaml).validate! }

    let(:yaml) do
      <<~YAML
      ---
      a: 1
      YAML
    end
    let(:parsed_nodes) { YAML.parse(yaml) }

    before do
      allow(YAML).to receive(:parse).and_return(parsed_nodes)
      allow(Yamcha::Composer).to receive_message_chain(:new, :compose)
    end

    it do
      expect(Yamcha::Composer).to receive(:new).with(node: parsed_nodes, enable_validator: true).once
      subject
    end

    context 'with argument `enable_validator: true`' do
      subject { described_class.new(yaml).validate!(enable_validator: true) }

      it do
        expect(Yamcha::Composer).to receive(:new).with(node: parsed_nodes, enable_validator: true).once
        subject
      end
    end

    context 'with argument `enable_validator: false`' do
      subject { described_class.new(yaml).validate!(enable_validator: false) }

      it do
        expect(Yamcha::Composer).to receive(:new).with(node: parsed_nodes, enable_validator: false).once
        subject
      end
    end
  end
end
