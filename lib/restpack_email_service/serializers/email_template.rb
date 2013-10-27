module RestPack::Email::Service::Serializers
  class EmailTemplate
    include RestPack::Serializer

    self.model_class = Models::EmailTemplate
    self.key = :email_templates

    attributes :id, :application_id, :identifier, :subject_template,
               :text_template, :html_template, :test_data
    can_filter_by :application_id
  end
end
