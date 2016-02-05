module FistOfFury
  class Dispatcher
    include Logging

    def dispatch(worker, time)
      enqueue(worker) if worker.scheduled_time_met?(time)
    rescue StandardError => e
      # TODO: exception handling support
      raise e
    end

    protected

    def enqueue(worker)
      klass = worker.to_s
      info "Enqueue: #{klass}"
      worker.new.async.perform
    rescue StandardError => e
      # TODO: exception handling support
      raise e
    end
  end
end
