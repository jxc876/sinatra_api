require 'redis'
require 'securerandom'

class AuthStore

  CREDENTIALS = 'credentials'
  TOKENS = 'tokens'
  @@redis = Redis.new(url: ENV['REDIS_URL'])

  def self.register (hash)
    username = hash['username']
    password = hash['password']

    if @@redis.hexists CREDENTIALS, username
      return false;
    else
      @@redis.hset CREDENTIALS, username, password
    end
  end

  def self.check_token(token)
    return @@redis.sismember TOKENS, token
  end

  def self.check_credential(hash)
    username = hash['username']
    password = hash['password']
    stored_pass = @@redis.hget CREDENTIALS, username
    return false unless password and password == stored_pass

    token = SecureRandom.uuid
    @@redis.sadd TOKENS, token

    {:username => username, :token => token}
  end

end
