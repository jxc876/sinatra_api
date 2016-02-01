require 'securerandom'

class Credential

  # --- instance vars & methods ---
  attr_reader :username, :password, :token

  def initialize (username, password)
    @username = username
    @password = password
    @token = ''
  end

  def generate_token
    @token = SecureRandom.uuid
  end

  def to_json
    { username: @username, token: @token }.to_json
  end

  def to_s
    to_json
  end

  def inspect
    to_s
  end

end
