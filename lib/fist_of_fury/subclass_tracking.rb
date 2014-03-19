module FistOfFury
  module SubclassTracking
    def subclasses(deep = false)
      @subclasses ||= []

      if deep
        @subclasses.inject([]) do |result, subclass|
          (result << subclass) + subclass.subclasses(true)
        end
      else
        @subclasses
      end
    end

    def inherited(klass)
      super
      subclasses << klass
    end
  end
end
