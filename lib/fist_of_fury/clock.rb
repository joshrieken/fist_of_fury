module FistOfFury
  class Clock
    include Logging

    attr_reader :schedules

    def schedule_for(worker)
      worker.schedule if worker.respond_to? :schedule
    end

    def current_time
      # TODO: configurable time zone support
      Time.now
    end

    protected

    def time
      start = current_time
      yield
      1 - (current_time.to_f - start.to_f)
    end

    def tick(tick = current_time)
      FistOfFury.workers.each do |worker|
        FistOfFury.dispatcher.dispatch(worker, tick)
      end
    end
  end
end
