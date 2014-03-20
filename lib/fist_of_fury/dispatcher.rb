module FistOfFury
  class Dispatcher
    include Logging

    def dispatch(worker, tick)
      schedule = worker.schedule
      return unless schedule.schedule_next?(tick)
      enqueue(worker, schedule.next_occurrence(tick))
    rescue StandardError => e
      # TODO: exception handling support
      raise e
    end

    protected

    def enqueue(worker, next_run_time)
      klass = worker.to_s
      info "Enqueue: #{klass}"
      last_run_time = FistOfFury.store["#{klass}:next"] || -1
      next_run_time = next_run_time.to_f
      FistOfFury.store["#{klass}:last"] = last_run_time
      FistOfFury.store["#{klass}:next"] = next_run_time
      worker.new.async.perform
    rescue StandardError => e
      # TODO: exception handling support
      raise e
    end
  end
end
