module FistOfFury
  class Clock
    include Logging

    attr_reader :schedules

    def schedule_for(worker)
      worker.schedule if worker.respond_to? :schedule
    end

    def current_time
      FistOfFury.config.utc ? Time.now.utc : Time.now
    end

    protected

    def time
      start = current_time
      yield
      1 - (current_time.to_f - start.to_f)
    end

    def tick(time = current_time)
      FistOfFury.workers.each do |worker|
        FistOfFury.dispatcher.dispatch(worker, time)
      end
    end
  end
end
