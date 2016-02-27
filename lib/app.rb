require 'sinatra/base'
require 'json'
require_relative './auth_store'

class App < Sinatra::Application

  # ----- App config -----
  set :environment, :development
  set :port, 9292

  # ----- Public Routes -----
  get '/' do
    'Hello world!'
  end

  post '/api/login' do
    user_pass = parse_body()
    credential = AuthStore.check_credential(user_pass)
    if (credential)
      credential.generate_token()
      AuthStore.save credential
      [200, credential.to_json]
    else
      [401, {message: 'invalid credentials'}.to_json]
    end
  end

  post '/api/register' do
    user_pass = parse_body()
    if (AuthStore.register user_pass)
      [200, { message: 'user created'}.to_json]
    else
      [400, { message: 'username already used' }.to_json]
    end
  end

  # ----- Secured Routes -----
  get '/api/notes' do
    token = request.env['HTTP_X_AUTH_TOKEN']
    if AuthStore.check_token(token)
      notes = ['note 1', 'note 2']
      [401, notes.to_json]
    else
      [401, { message: 'not authorized' }.to_json]
    end

  end

  # ----- Helper Methods -----

  def parse_body
    request.body.rewind
    JSON.parse request.body.read
  end

  # ----- Start Server -----
  run! if app_file == $0
end
