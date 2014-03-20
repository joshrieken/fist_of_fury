require 'spec_helper'

describe FistOfFury::Schedule do
  let(:schedule) { subject }

  describe '#initialize' do
    it 'creates an IceCube schedule' do
      ice_cube_schedule = double 'ice_cube_schedule'
      allow(IceCube::Schedule).to receive(:new).with(described_class::START_TIME).and_return(ice_cube_schedule)
      expect(schedule.ice_cube_schedule).to eq ice_cube_schedule
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
        allow(schedule).to receive(:schedule_next?).and_return(true)
      end

      it 'calls the block' do
        block_called = false
        schedule.schedule_next(time) { block_called = true }
        expect(block_called).to be_true
      end

      it 'sets the last occurrence' do
        expect(schedule).to receive(:last_occurrence=).with(next_occurrence)
        schedule.schedule_next(time, &block)
      end
    end

    context 'when it should not be scheduled' do
      before :each do
        allow(schedule).to receive(:schedule_next?).and_return(false)
      end

      it 'does not call the block' do
        block_called = false
        schedule.schedule_next(time) { block_called = true }
        expect(block_called).to be_false
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
end
