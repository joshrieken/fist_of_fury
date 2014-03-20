require 'spec_helper'

shared_examples_for 'an actor' do
  it 'mixes in Celluloid' do
    expect(subject).to respond_to(:after)
  end
end
