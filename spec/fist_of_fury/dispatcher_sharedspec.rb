require 'spec_helper'
require 'fist_of_fury/logging_sharedspec'

shared_examples_for 'a dispatcher' do
  it_should_behave_like 'a logger'

  describe '#dispatch' do

    let(:time) { double('time') }

    let(:worker) { double('worker') }

    it 'delegates scheduling to the worker' do
      expect(worker).to receive(:schedule_next) do |*args, &block|
        expect(args).to include(time)
        expect(block).to_not be_nil
      end
      subject.dispatch(worker, time)
    end
  end
end
