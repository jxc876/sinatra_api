require 'mongo'
require 'securerandom'

class AuthStore

  USERS = 'users'
  TOKENS = 'tokens'
  @@mongo = Mongo::Client.new(ENV['MONGOLAB_URI'])

  def self.register (hash)
    username = hash['username']
    password = hash['password']

    if @@mongo[USERS].find(username: username).count > 0
      return false;
    else
      @@mongo[USERS].insert_one({username: username, password: password})
    end
  end

  def self.check_token(token)
    return @@mongo[TOKENS].find(token: token).count > 0
  end

  def self.check_credential(hash)
    username = hash['username']
    password = hash['password']

    user = @@mongo[USERS].find(username: username).first
    if user
      stored_pass = user['password']
    end

    # exit if credentials don't match
    return false unless password and password == stored_pass

    token = SecureRandom.uuid
    @@mongo[TOKENS].insert_one({token: token, username: username})

    {:username => username, :token => token}
  end

end
