module FistOfFury
  module Recurrent
    extend SubclassTracking

    module ClassMethods
      include SubclassTracking

      attr_writer :schedule

      def schedule
        @schedule ||= FistOfFury::Schedule.new
      end

      def recurs(options={}, &block)
        schedule.instance_eval(&block)
        schedule.options = options
      end

      def scheduled_time_met?(time)
        schedule.scheduled_time_met?(time)
      end
    end

    def self.included(klass)
      super

      klass.extend(FistOfFury::Recurrent::ClassMethods)
      klass.extend(FistOfFury::SubclassTracking)
      subclasses << klass
    end
  end
end
