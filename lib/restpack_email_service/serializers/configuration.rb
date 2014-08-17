module Email::Serializers
  class Configuration
    include RestPack::Serializer

    self.model_class = Email::Models::Configuration
    self.key = :configurations

    attributes :id, :application_id, :domain_id, :smtp_server,
               :smtp_username, :smtp_password, :smtp_port, :default_from
    can_filter_by :application_id
  end
end
