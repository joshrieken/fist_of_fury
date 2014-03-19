module FistOfFury
  module Recurrent
    extend SubclassTracking

    module ClassMethods
      include SubclassTracking

      attr_writer :schedule

      def schedule
        @schedule ||= FistOfFury::Schedule.new
      end

      def last_scheduled_occurrence
        scheduled_occurrence 'last'
      end

      def next_scheduled_occurrence
        scheduled_occurrence 'next'
      end

      def recurs(options={}, &block)
        schedule.instance_eval(&block)
        schedule.options = options
      end

      private

      def scheduled_occurrence(key)
        (FistOfFury.store["#{self.class.to_s}:#{key}"] || -1).to_f
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
