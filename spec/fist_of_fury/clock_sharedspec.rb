require 'spec_helper'
require 'fist_of_fury/logging_sharedspec'

shared_examples_for 'a clock' do
  it_should_behave_like 'a logger'

  describe '#schedule_for' do
    it "delegates to the worker's schedule" do
      worker = double('worker')
      worker.stub(:schedule)
      expect(worker).to receive(:schedule)
      subject.schedule_for(worker)
    end
  end

  describe '#current_time' do
    context 'when UTC is enabled' do
      before :each do
        FistOfFury.configure { |config| config.utc = true }
      end

      it 'returns the current time in UTC' do
        now = double('now')
        utc = double('utc')
        now.stub(:utc).and_return(utc)
        Time.stub(:now).and_return(now)
        expect(subject.current_time).to eq utc
      end
    end

    context 'when UTC is not enabled' do
      before :each do
        FistOfFury.configure { |config| config.utc = false }
      end

      it 'returns the current time in the default time zone' do
        now = double('now')
        Time.stub(:now).and_return(now)
        expect(subject.current_time).to eq now
      end
    end
  end
end
