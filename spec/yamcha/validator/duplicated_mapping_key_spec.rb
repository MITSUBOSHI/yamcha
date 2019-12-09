# frozen_string_literal: true

RSpec.describe Yamcha::Validator::DuplicatedMappingKey do
  describe ".validate!" do
    subject { described_class.validate!(key_name: key_name, hash: hash) }

    context 'when hash has the duplicated key' do
      let(:key_name) { 'fuga' }
      let(:hash) do
        {
          'hoge' => '1',
          'fuga' => '2'
        }
      end

      it do
        expect{ subject }.to raise_error(Yamcha::Validator::DuplicatedMappingKey::Error, 'duplicated key `fuga` exists')
      end
    end

    context 'when hash does not have the duplicated key' do
      let(:key_name) { 'fuga' }
      let(:hash) do
        {
          'hoge' => '1'
        }
      end

      it do
        expect{ subject }.not_to raise_error
      end
    end
  end
end
