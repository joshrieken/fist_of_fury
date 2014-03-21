module FistOfFury
  class << self
    attr_writer :config

    def configure
      yield config
    end

    def configure_with_defaults
      config.utc = false
      yield config if block_given?
    end

    def config
      @config ||= OpenStruct.new
    end
  end

  configure_with_defaults
end
