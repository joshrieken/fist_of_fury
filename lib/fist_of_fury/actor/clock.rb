module FistOfFury
  module Actor
    class Clock < FistOfFury::Clock
      include FistOfFury::Actor

      def initialize(*args, &block)
        after(0) do
          debug 'FistOfFury::Clock starting loop...'
          loop!
        end
      end

      private

      def loop!
        after([time { tick }, 0].max) do
          loop!
        end
      rescue StandardError => e
        # TODO: global exception handling support
        # handle_exception(e, context: 'FistOfFury::Clock#loop!')
        raise e
      end
    end
  end
end
