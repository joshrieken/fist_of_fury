module FistOfFury
  class Schedule
    attr_accessor :options, :ice_cube_schedule, :last_occurrence

    def initialize
      start_time = FistOfFury.config.utc ? Time.now.utc : Time.now
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

    def scheduled_time_met?(time)
      self.last_occurrence = next_occurrence(time) unless last_occurrence
      return false if last_occurrence_is_next_occurrence?(time)
      self.last_occurrence = next_occurrence(time)
      true
    end

    def to_s
      ice_cube_schedule.to_s
    end

    private

    def last_occurrence_is_next_occurrence?(time)
      last_occurrence == next_occurrence(time)
    end

    def next_occurrence(time)
      ice_cube_schedule.next_occurrence(time)
    end
  end
end
