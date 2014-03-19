module FistOfFury
  module Logging
    [:fatal, :error, :warn, :info, :debug].each do |level|
      define_method(level) do |msg|
        FistOfFury.logger.__send__(level, "[FistOfFury] #{msg}")
      end
    end
  end
end
