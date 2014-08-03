require 'spec_helper'

describe FistOfFury::Schedule do
  let(:schedule) { subject }

  describe '#initialize' do
    it 'creates an IceCube schedule' do
      ice_cube_schedule = double('ice_cube_schedule')
      start_time = double('start_time')
      allow_any_instance_of(described_class).to receive(:start_time).and_return(start_time)
      allow(IceCube::Schedule).to receive(:new).with(start_time).and_return(ice_cube_schedule)
      expect_any_instance_of(described_class).to receive(:ice_cube_schedule=).with(ice_cube_schedule)
      schedule
    end
  end

  describe '#schedule_next' do
    let(:time) { double('time') }
    let(:block) { lambda {} }
    let(:next_occurrence) { double('next_occurrence') }

    before :each do
      allow(schedule).to receive(:next_occurrence).and_return(next_occurrence)
    end

    context 'when it should be scheduled' do
      before :each do
        allow(schedule).to receive(:can_schedule_next?).and_return(true)
      end

      it 'calls the block' do
        block_called = false
        schedule.schedule_next(time) { block_called = true }
        expect(block_called).to eq true
      end

      it 'sets the last occurrence' do
        expect(schedule).to receive(:last_occurrence=).with(next_occurrence)
        schedule.schedule_next(time, &block)
      end
    end

    context 'when it should not be scheduled' do
      before :each do
        allow(schedule).to receive(:can_schedule_next?).and_return(false)
      end

      it 'does not call the block' do
        block_called = false
        schedule.schedule_next(time) { block_called = true }
        expect(block_called).to eq false
      end

      it 'does not set the last occurrence' do
        expect(schedule).not_to receive(:last_occurrence=).with(next_occurrence)
        schedule.schedule_next(time, &block)
      end
    end
  end

  describe '#to_s' do
    it 'delegates to ice_cube_schedule' do
      expect(schedule.ice_cube_schedule).to receive(:to_s)
      schedule.to_s
    end
  end

  describe '#start_time' do
    context 'when utc is enabled' do
      before :each do
        FistOfFury.configure do |config|
          config.utc = true
        end
      end

      it 'returns the utc start time' do
        now = double('now')
        allow(now).to receive(:utc).and_return(Time.now.utc)
        expect(Time).to receive(:now).and_return now
        schedule
      end
    end

    context 'when utc is not enabled' do
      it 'returns the local start time' do
        expect(Time).to receive(:now).and_return(Time.now.utc)
        schedule
      end
    end
  end
end
