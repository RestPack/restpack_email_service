module RestPack::Email::Service::Models
  class EmailTemplate < ActiveRecord::Base
    self.table_name = :restpack_email_templates

    attr_accessible :application_id, :identifier, :text_template, :html_template
    validates_presence_of :application_id, :identifier, :text_template, :html_template
  end
end
