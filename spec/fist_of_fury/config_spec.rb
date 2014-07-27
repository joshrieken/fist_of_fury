require 'spec_helper'

describe FistOfFury do
  describe 'config' do
    describe '#configure' do
      let(:config) { OpenStruct.new }

      before :each do
        described_class.config = config
      end

      it 'calls the block and yields the config ' do
        block_called = false
        described_class.configure do |config|
          expect(config).to eq(config)
          block_called = true
        end
        expect(block_called).to eq true
      end
    end

    describe '#configure_with_defaults' do
      let(:config) { OpenStruct.new }

      before :each do
        described_class.config = config
      end

      it 'calls the block and yields the config ' do
        block_called = false
        described_class.configure_with_defaults do |config|
          expect(config).to eq(config)
          block_called = true
        end
        expect(block_called).to eq true
      end
    end

    describe '#config' do
      it 'has some default values' do
        expect(described_class.config).to eq OpenStruct.new(
          utc: false
        )
      end
    end
  end
end
