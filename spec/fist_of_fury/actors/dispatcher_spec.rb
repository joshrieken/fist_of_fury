require 'spec_helper'
require 'fist_of_fury/actor_sharedspec'
require 'fist_of_fury/logging_sharedspec'

describe FistOfFury::Actor::Dispatcher do
  it_should_behave_like 'an actor'
  it_should_behave_like 'a logger'

  let(:dispatcher) { subject }

  describe '#dispatch' do

    let(:worker) do
      worker = double('worker')
      worker.stub(:schedule).and_return(schedule)
      worker
    end

    let(:schedule) { double('schedule') }

    let(:tick) { double('tick') }

    let(:next_occurrence) { double('next_occurrence') }

    context 'when the next job should be scheduled' do
      before :each do
        schedule.stub(:schedule_next?).and_return(true)
        schedule.stub(:next_occurrence).and_return(next_occurrence)
      end

      it 'enqueues the worker' do
        expect_any_instance_of(described_class).to receive(:enqueue).with(worker, next_occurrence)
        dispatcher.dispatch(worker, tick)
      end
    end

    context 'when the next job should not be scheduled' do
      before :each do
        schedule.stub(:schedule_next?).and_return(false)
      end

      it 'does not enqueue the worker' do
        expect_any_instance_of(described_class).not_to receive(:enqueue)
        dispatcher.dispatch(worker, tick)
      end
    end
  end
end
