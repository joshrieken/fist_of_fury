require 'spec_helper'
require 'fist_of_fury/recurrent_sharedspec'

class AwesomeJob
  include SuckerPunch::Job
  include FistOfFury::Recurrent
end

describe AwesomeJob do
  it_should_behave_like 'a job with recurrence'
end
