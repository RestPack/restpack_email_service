module RestPack::Email::Service::Serializers
  class EmailSetting
    include RestPack::Serializer

    self.model_class = Models::EmailSetting
    self.key = :email_settings

    attributes :id, :application_id, :domain_id, :smtp_server,
               :smtp_username, :smtp_password, :smtp_port, :default_from
    can_filter_by :application_id
  end
end
