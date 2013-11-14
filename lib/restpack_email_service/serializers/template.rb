module Serializers::Email
  class Template
    include RestPack::Serializer

    self.model_class = Models::Email::Template
    self.key = :templates

    attributes :id, :application_id, :identifier, :subject_template,
               :text_template, :html_template, :data
    can_filter_by :application_id
  end
end
