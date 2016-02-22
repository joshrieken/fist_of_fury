module FistOfFury
  class Supervisor < Celluloid::Supervision::Container 
    supervise type: FistOfFury::Actor::Clock, as: :fist_of_fury_clock
    # TODO: configurable pool size. For now, use Celluloid's CPU-based default.
    pool FistOfFury::Actor::Dispatcher, as: :fist_of_fury_dispatcher

    class << self
      include Logging

      def clock
        run! if Celluloid::Actor[:fist_of_fury_clock].nil?
        Celluloid::Actor[:fist_of_fury_clock]
      end

      def dispatcher
        run! if Celluloid::Actor[:fist_of_fury_dispatcher].nil?
        Celluloid::Actor[:fist_of_fury_dispatcher]
      end

      def run!
        info 'FistOfFury::Supervisor start'
        super
      end
    end
  end
end
