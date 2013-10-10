module RestPack::Email::Service::Serializers
  class EmailSetting
    include RestPack::Serializer

    self.model_class = Models::EmailSetting
    self.key = :settings

    attributes :id, :application_id, :provider, :username, :secret
    can_filter_by :application_id
  end
end
