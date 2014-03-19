module FistOfFury
  module Actor
    class Clock
      include Logging
      include FistOfFury::Actor

      attr_reader :schedules

      def initialize(*args, &block)
        after(0) do
          debug 'FistOfFury::Clock looping...'
          loop!
        end
      end

      def schedule_for(worker)
        worker.schedule if worker.respond_to? :schedule
      end

      def tick(tick = current_time)
        FistOfFury.workers.each do |worker|
          FistOfFury.dispatcher.dispatch(worker, tick)
        end
      end

      def current_time
        # TODO: configurable time zone support
        Time.now
      end

      private

      def loop!
        after([time { tick }, 0].max) do
          loop!
        end
      rescue StandardError => e
        # TODO: global exception handling support
        # handle_exception(e, context: 'FistOfFury::Clock#loop!')
        raise e
      end

      def time
        start = current_time
        yield
        1 - (current_time.to_f - start.to_f)
      end
    end
  end
end
