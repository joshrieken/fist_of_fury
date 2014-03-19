module FistOfFury
  module API
    def workers
      FistOfFury::Recurrent.subclasses(true)
    end

    def schedules
      workers.map(&:schedule)
    end
  end
end
