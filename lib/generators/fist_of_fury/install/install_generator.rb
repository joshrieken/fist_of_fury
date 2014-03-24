require 'rails/generators/base'

module FistOfFury
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Description:\n Copy Fist of Fury files to your application."

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_initializer
        directory 'config'
      end
    end
  end
end
