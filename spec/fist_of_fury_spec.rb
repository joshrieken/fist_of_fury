require 'spec_helper'

describe FistOfFury do
  describe 'logger' do
    it "delegates get to Sucker Punch's logger" do
      expect(FistOfFury.logger).to eq SuckerPunch.logger
    end
  end

  describe 'clock' do
    it "delegates get to FistOfFury::Supervisor's clock" do
      expect(FistOfFury::Supervisor).to receive(:clock)
      FistOfFury.clock
    end
  end

  describe 'store' do
    it 'starts out as an empty hash' do
      expect(FistOfFury.store).to eq Hash.new
    end
  end
end
