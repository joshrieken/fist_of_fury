require 'spec_helper'
require 'fist_of_fury/actor_sharedspec'
require 'fist_of_fury/dispatcher_sharedspec'

describe FistOfFury::Actor::Dispatcher do
  it_should_behave_like 'an actor'
  it_should_behave_like 'a dispatcher'
end
