require 'spec_helper'

shared_examples_for 'the api' do
  describe '#workers' do
    it 'returns the deep subclass list from Recurrent' do
      expect(FistOfFury::Recurrent).to receive(:subclasses).with(true)
      subject.workers
    end
  end

  describe '#schedules' do
    it 'returns the worker schedules' do
      worker_list = double('worker_list')
      expect(worker_list).to receive(:map)
      allow_any_instance_of(described_class).to receive(:workers).and_return(worker_list)
      subject.schedules
    end
  end
end
