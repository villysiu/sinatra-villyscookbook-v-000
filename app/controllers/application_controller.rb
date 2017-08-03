require './config/environment'
require'./app/models/user'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :method_override, true
  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }

    enable :sessions
    set :session_secret, "password_security"

  end


end
