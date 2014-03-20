begin
  require 'pry'
rescue LoadError
end

if RUBY_PLATFORM != "java"
  require 'coveralls'
  Coveralls.wear!
end

require 'fist_of_fury'

class FistOfFury::Supervisor
  def self.clock
    @clock ||= FistOfFury::Clock.new
  end

  def self.dispatcher
    @dispatcher ||= FistOfFury::Dispatcher.new
  end
end

Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.rb')].each do |fixture|
  require fixture
end
RSpec.configure do |config|
  config.after(:each) do
    # Clean up the master queue list
    SuckerPunch::Queues.instance_variable_set(:@queues, Set.new)
  end
end
