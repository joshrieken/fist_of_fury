require 'spec_helper'
require 'fist_of_fury/actor_sharedspec'
require 'fist_of_fury/clock_sharedspec'

describe FistOfFury::Actor::Clock do
  it_should_behave_like 'an actor'
  it_should_behave_like 'a clock'

  let(:clock) { subject }

  before :each do
    expect_any_instance_of(described_class).to receive(:after)
  end

  describe '#initialize' do
    it 'makes a deferred call' do
      clock
    end
  end
end
