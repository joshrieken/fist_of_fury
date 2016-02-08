require 'spec_helper'
require 'fist_of_fury/api_sharedspec'

describe FistOfFury do
  it_should_behave_like 'the api'

  describe '#logger' do
    before :each do
      FistOfFury.logger = nil
    end

    it "delegates to Sucker Punch's logger" do
      expect(FistOfFury.logger).to eq SuckerPunch.logger
    end

    after :each do
      FistOfFury.logger = Logger.new(nil)
    end
  end

  describe '#clock' do
    it "delegates to the supervisor's clock" do
      expect(FistOfFury::Supervisor).to receive(:clock)
      FistOfFury.clock
    end
  end

  describe '#dispatcher' do
    it "delegates to the supervisor's dispatcher" do
      expect(FistOfFury::Supervisor).to receive(:dispatcher)
      FistOfFury.dispatcher
    end
  end

  describe '#attack!' do
    it 'calls the block when provided' do
      allow(FistOfFury::Supervisor).to receive(:run!)
      block_called = false
      FistOfFury.attack! { block_called = true }
      expect(block_called).to eq true
    end

    it 'calls #run! on the supervisor' do
      expect(FistOfFury::Supervisor).to receive(:run!)
      FistOfFury.attack!
    end
  end
end
