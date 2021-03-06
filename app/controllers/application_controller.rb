require 'rack-flash'
require './config/environment'
require "./app/models/user"

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :method_override, true
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :views, Proc.new { File.join(root, "../views/") }

    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end

  get '/' do
    if logged_in?
      redirect "/recipes"
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end
end
