module RestPack::Email::Service
  class Configuration < RestPack::Service::Configuration

  end

  mattr_accessor :config
  @@config = Configuration.new

  def self.setup
    yield @@config
  end
end
