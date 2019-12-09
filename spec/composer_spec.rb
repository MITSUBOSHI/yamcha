# frozen_string_literal: true

RSpec.describe Yamcha::Composer do
  describe "#compose" do
    subject { described_class.new(node: node).compose }

    let(:node) { YAML.parse(yaml) }

    context 'when yaml has scalar and scalar' do
      let(:yaml) do
        <<~YAML
          ---
          a: 1
        YAML
      end

      it do
        is_expected.to eq(
          {
            "a" => "1"
          }
        )
      end
    end

    context 'when yaml has scalar and sequence' do
      let(:yaml) do
        <<~YAML
          ---
          a:
            - 1
            - 2
            - 3
        YAML
      end

      it do
        is_expected.to eq(
          {
            "a" => ["1", "2", "3"]
          }
        )
      end
    end

    context 'when yaml has scalar and mapping' do
      let(:yaml) do
        <<~YAML
          ---
          a:
            b:
              c:
                1
        YAML
      end

      it do
        is_expected.to eq(
          {
            "a" => {
              "b" => {
                "c" => "1"
              }
            }
          }
        )
      end
    end

    context 'when yaml has a duplicated mapping key' do
      let(:yaml) do
        <<~YAML
          ---
          a:
            b:
              c:
                1
            b:
              d:
                2
        YAML
      end

      context 'when enable_validator option is true' do
        it do
          expect{ subject }.to raise_error(Yamcha::Validator::DuplicatedMappingKey::Error, "duplicated key `b` exists")
        end
      end

      context 'when enable_validator option is false' do
          subject { described_class.new(node: node, enable_validator: false).compose }

        it do
          is_expected.to eq(
            {
              "a" => {
                "b" => {
                  "d" => "2"
                }
              }
            }
          )
        end
      end
    end
  end
end
