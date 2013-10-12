module RestPack::Email::Service::Serializers
  class EmailTemplate
    include RestPack::Serializer

    self.model_class = Models::EmailTemplate
    self.key = :templates

    attributes :id, :application_id, :identifier, :template
    can_filter_by :application_id
  end
end
