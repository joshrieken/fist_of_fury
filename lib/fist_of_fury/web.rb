require 'erb'
require 'yaml'
require 'sinatra/base'

module FistOfFury
  class Web < Sinatra::Base

    set :root, File.expand_path(File.dirname(__FILE__) + "/../../web")
    set :public_folder, Proc.new { "#{root}/assets" }
    set :views, Proc.new { "#{root}/views" }

    get '/' do
      erb :dashboard
    end

  end
end
