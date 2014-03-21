# stdlib
require 'ostruct'
require 'singleton'
require 'socket'
require 'time'

# gems
require 'ice_cube'
require 'sucker_punch'
require 'celluloid'

# internal
require 'fist_of_fury/config'
require 'fist_of_fury/subclass_tracking'
require 'fist_of_fury/api'
require 'fist_of_fury/logging'
require 'fist_of_fury/schedule'
require 'fist_of_fury/clock'
require 'fist_of_fury/dispatcher'
require 'fist_of_fury/recurrent'
require 'fist_of_fury/version'

# actor topology
require 'fist_of_fury/actor'
require 'fist_of_fury/actor/clock'
require 'fist_of_fury/actor/dispatcher'
require 'fist_of_fury/supervisor'

module FistOfFury
  include FistOfFury::API

  extend self

  class << self
    attr_writer :logger
  end

  def logger
    @logger ||= SuckerPunch.logger
  end

  def clock
    FistOfFury::Supervisor.clock
  end

  def dispatcher
    FistOfFury::Supervisor.dispatcher
  end

  def store
    @store ||= {}
  end

  def attack!
    yield if block_given?
    FistOfFury::Supervisor.run!
  end
end

require 'fist_of_fury/railtie' if defined?(::Rails)
