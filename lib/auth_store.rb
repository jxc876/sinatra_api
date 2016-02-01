require './credential'

class AuthStore
  # --- class vars & methods ---
  @@credentials = []
  @@tokens = {}

  def self.credentials
    @@credentials
  end

  def self.tokens
    @@tokens
  end

  def self.save(credential)
    @@tokens[credential.token] = credential
  end

  def self.check_token(token)
    @@tokens[token]
  end

  def self.register (hash)
    username_taken = @@credentials.any? do |cred|
      cred.username == hash['username']
    end
    if username_taken
      return false;
    else
      username = hash['username']
      password = hash['password']
      credential = Credential.new(username, password)
      @@credentials << credential
    end
  end

  def self.check_credential(hash)
    @@credentials.find do |cred|
      cred.username == hash['username'] and cred.password == hash['password']
    end
  end

  # --- instance vars & methods ---

  # --- populate some data ---
  @@credentials << Credential.new('admin', 'secret')

end
