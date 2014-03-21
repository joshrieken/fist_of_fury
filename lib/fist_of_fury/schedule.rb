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
      return unless schedule_next?(time)
      yield
      self.last_occurrence = next_occurrence(time)
    end

    def to_s
      ice_cube_schedule.to_s
    end

    def start_time
      @start_time ||= FistOfFury.config.utc ? Time.utc(2010, 1, 1) : Time.local(2010, 1, 1)
    end

    private

    def next_occurrence(time)
      ice_cube_schedule.next_occurrence(time)
    end

    def schedule_next?(time)
      last_occurrence != next_occurrence(time)
    end
  end
end
