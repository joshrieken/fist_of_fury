module FistOfFury
  class Schedule
    attr_accessor :options
    attr_reader :last_occurrence

    # TODO: configurable timezone support
    START_TIME = Time.local(2010, 1, 1)

    def initialize
      @schedule = IceCube::Schedule.new(START_TIME)
    end

    def method_missing(meth, *args, &block)
      if IceCube::Rule.respond_to?(meth)
        rule = IceCube::Rule.send(meth, *args, &block)
        @schedule.add_recurrence_rule(rule)
        rule
      elsif @schedule.respond_to?(meth)
        @schedule.send(meth, *args, &block)
      else
        super
      end
    end

    def schedule_next?(time)
      next_occurrence = @schedule.next_occurrence(time)
      if @last_scheduled != next_occurrence
        @last_scheduled = next_occurrence
        true
      else
        false
      end
    end

    def to_s
      @schedule.to_s
    end
  end
end
