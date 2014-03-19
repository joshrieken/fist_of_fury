module FistOfFury
  module Actor
    def self.included(base)
      base.__send__(:include, Celluloid)
      base.finalizer :fist_of_fury_finalizer
    end

    def initialize(*args, &block)
      log_call 'initialize'
      super
    end

    private

    def fist_of_fury_finalizer
      log_call 'shutting down ...'
    end

    def log_call(call)
      info "#{self.class.name} id: #{object_id} #{call}"
    end
  end
end
