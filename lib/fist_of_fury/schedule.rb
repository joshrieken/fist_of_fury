module FistOfFury
  class Schedule
    attr_accessor :options, :ice_cube_schedule, :last_occurrence

    def initialize
      self.ice_cube_schedule = IceCube::Schedule.new(start_time)
    end

    def method_missing(meth, *args, &block)
      if IceCube::Rule.respond_to?(meth)
        rule = IceCube::Rule.send(meth, *args, &block)
        ice_cube_schedule.add_recurrence_rule(rule)
        rule
      elsif ice_cube_schedule.respond_to?(meth)
        ice_cube_schedule.send(meth, *args, &block)
      else
        super
      end
    end

    def schedule_next(time)
      return unless can_schedule_next?(time)
      self.last_occurrence = next_occurrence(time)
      yield
    end

    def to_s
      ice_cube_schedule.to_s
    end

    def start_time
      @start_time ||= FistOfFury.config.utc ? Time.now.utc : Time.now
    end

    private

    def next_occurrence(time)
      ice_cube_schedule.next_occurrence(time)
    end

    def can_schedule_next?(time)
      unless last_occurrence
        self.last_occurrence = next_occurrence(time)
      end
      last_occurrence != next_occurrence(time)
    end
  end
end
