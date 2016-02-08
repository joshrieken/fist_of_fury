require 'spec_helper'
require 'fist_of_fury/logging_sharedspec'

shared_examples_for 'a dispatcher' do
  it_should_behave_like 'a logger'

  describe '#dispatch' do

    let(:time) { double('time') }

    let(:worker) { double('worker') }

    it 'does not enqueue the worker if the scheduled time has not been met' do
      expect(worker).to receive(:scheduled_time_met?).with(time).and_return(false)
      subject.dispatch(worker, time)
    end

    it 'enqueues the worker when the schedule time is met' do
      expect(worker).to receive(:scheduled_time_met?).with(time).and_return(true)
      double_worker = double('worker')
      double_async = double('async')
      expect(worker).to receive(:new).and_return(double_worker)
      expect(double_worker).to receive(:async).and_return(double_async)
      expect(double_async).to receive(:perform)
      subject.dispatch(worker, time)
    end
  end
end
