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
    it 'returns the current time' do
      now = double('now')
      Time.stub(:now).and_return(now)
      expect(subject.current_time).to eq now
    end
  end
end
