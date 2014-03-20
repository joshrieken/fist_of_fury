require 'spec_helper'
require 'fist_of_fury/actor_sharedspec'
require 'fist_of_fury/logging_sharedspec'

describe FistOfFury::Actor::Clock do
  it_should_behave_like 'an actor'
  it_should_behave_like 'a logger'

  context 'with a fake #tick' do
    let(:clock) { subject }

    before :each do
      allow_any_instance_of(described_class).to receive(:tick).and_return(nil)
      expect_any_instance_of(described_class).to receive(:after)
    end

    describe '#initialize' do
      it 'makes a deferred call' do
        clock
      end
    end

    describe '#schedule_for' do
      it "delegates to the worker's schedule" do
        worker = double('worker')
        worker.stub(:schedule)
        expect(worker).to receive(:schedule)
        clock.schedule_for(worker)
      end
    end

    describe '#current_time' do
      it 'returns the current time' do
        now = double('now')
        Time.stub(:now).and_return(now)
        expect(clock.current_time).to eq now
      end
    end
  end
end
